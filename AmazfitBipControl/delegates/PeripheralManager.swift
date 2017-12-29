//
//  PeripheralManager.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 25.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth


class PeripheralManager: NSObject, CBPeripheralManagerDelegate {
    static let PeripheralManagerRestorationKey = "PeripheralManager"
    var manager: CBPeripheralManager?
    var DVCEService: CBMutableService?
    var delegateQueue: DispatchQueue?
    var state: CBManagerState?
    var shouldAdvertise: Bool?
    var delegateFlags: PeripheralManagerDelegateFlags
    var deviceUUID: CBUUID?
    
    private var delegate: PeripheralManagerDelegate?
    var peripheralManagerDelegate: PeripheralManagerDelegate? {
        get {
            return self.delegate
        }
        set {
            if newValue != nil && (self.delegate == nil || !(self.delegate?.isEqual(newValue))!) {
                self.delegate = newValue
                self.delegateFlags.didStartAdvertising = self.delegate?.responds(to: #selector(PeripheralManagerDelegate.didStartAdvertisingWithError(_:error:)))
            }
        }
    }
    
    var isAdvertising: Bool? {
        return self.manager?.isAdvertising
    }
    
    var keyPathsForValuesAffectingAdvertising: NSSet {
        return NSSet.init(object: "manager.isAdvertising")
    }
    
    
    init(withUID: String) {
        self.delegateFlags = PeripheralManagerDelegateFlags()
        self.delegateFlags.didStartAdvertising = false
        super.init()
        
        self.delegateQueue = DispatchQueue(label: "ru.krutskikh.amazfitcontrol.DispatchQueue", attributes: [], target: nil)
        var options = [String: Any]()
        options[CBPeripheralManagerOptionShowPowerAlertKey] = true
        if (withUID.count > 0) {
            options[CBPeripheralManagerOptionRestoreIdentifierKey] = withUID;
        }
        self.manager = CBPeripheralManager.init(delegate: self, queue: self.delegateQueue, options: options)
        self.deviceUUID = CBUUID(nsuuid: UIDevice.current.identifierForVendor!)
    }
    
    func startAdvertising() {
        self.shouldAdvertise = true
        if (self.manager?.state == CBManagerState.poweredOn && !(self.manager?.isAdvertising)!) {
            Utils.log("startAdvertising", from: classForCoder, args: ["manager": manager])
            var advertisementData = [String: Any]()
            let svUUID = CBUUID.init(string: DefinesConstant.ANCS_SV_UUID.rawValue)
            let devUUID = CBUUID.init(nsuuid: UIDevice.current.identifierForVendor!)
            advertisementData[CBAdvertisementDataServiceUUIDsKey] = [svUUID, devUUID] //TODO
            advertisementData[CBAdvertisementDataLocalNameKey] = UIDevice.current.name
        
            self.manager?.startAdvertising(advertisementData)
        }
    }
    
    func stopAdvertising() {
        self.shouldAdvertise = false
        self.manager?.stopAdvertising()
    }
    
//    func setDelegate(delegate: PeripheralManagerDelegate) {
//        if self.peripheralManagerDelegate != delegate {
//            //
//        }
//    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        self.state = peripheral.state
        if (self.state == CBManagerState.poweredOn) {
            Utils.log("peripheralManagerDidUpdateState", from: classForCoder, args: ["peripheral": peripheral])
            
            if (self.DVCEService == nil) {
                self.DVCEService = self.newDVCEService()
                self.manager?.add(self.DVCEService!)
            }
        } else {
            self.stopAdvertising()
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        Utils.log("peripheralManagerDidStartAdvertising", from: classForCoder, args: ["peripheral": peripheral])
        if (self.delegateFlags.didStartAdvertising)! {
            let dispatchQueue = DispatchQueue(label: "Peripheral Manager", attributes: [], target: nil)
            dispatchQueue.async {
                DispatchQueue.main.async(execute: {
                    self.delegate?.didStartAdvertisingWithError?(self, error: error)
                })
            }
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, willRestoreState dict: [String : Any]) {
        Utils.log("willRestoreState", from: classForCoder, args: dict)
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        Utils.log("didAdd", from: classForCoder, args: ["service": service])
        if (self.shouldAdvertise)! {
            self.startAdvertising()
        }
    }
    
    func deviceNameData() -> Data? {
        return UIDevice.current.name.data(using: .utf8)
    }
    
    func deviceModelData() -> Data? {
        var size: size_t = 20
        let model: UnsafeMutableRawPointer = malloc(size)
        
        var mib = [CTL_HW, HW_MACHINE]
        sysctl(&mib, 2, model, &size, nil, 0);
        // Using size - 1 because we want to strip out the terminating null byte, which
        // NSString does not like.
        let data = Data.init(bytes: model, count: size - 1)
        free(model);
        return data
    }
    
    func newDVCEService() -> CBMutableService {
        let service = CBMutableService.init(type: self.deviceUUID!, primary: true)
        let deviceName = self.deviceNameData()
        let modelData = self.deviceModelData()
        
        
        let NMCharacteristic = CBMutableCharacteristic.init(type: CBUUID.init(string: "D4546067-C583-498B-B450-4D56DA9E206F"), properties: CBCharacteristicProperties.read, value: deviceName, permissions: CBAttributePermissions.readable)
        let MLCharacteristic = CBMutableCharacteristic.init(type: CBUUID.init(string: "517F5BB8-81C6-4FCD-B4E9-9AF263D7B7D8"), properties: CBCharacteristicProperties.read, value: modelData, permissions: CBAttributePermissions.readable)
        service.characteristics = [NMCharacteristic, MLCharacteristic]
        return service;
    }
}
