//
//  BluetoothManager.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 20.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, CBPeripheralManagerDelegate, DataQueryDelegate {
    
    var bluetoothDelegate: BluetoothDelegate?
    var dataQueryDelegate: DataQueryDelegate?
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var _manager: CBCentralManager?
    private(set) var connected = false
    var state: CBManagerState? {
        guard _manager != nil else {
            return nil
        }
        return CBManagerState(rawValue: (_manager?.state.rawValue)!)
    }
    //private var isConnecting = false
    
    private(set) var selectedPeripheral: CBPeripheral?
    var peripferal: CBPeripheral? {
        get {
            return self.selectedPeripheral
        }
        set {
            if newValue != nil {
                self.selectedPeripheral = newValue
                self.selectedPeripheral!.delegate = self
                self._manager!.connect(self.selectedPeripheral!, options:nil)
            } else {
                self._manager!.cancelPeripheralConnection(self.selectedPeripheral!)
                self.selectedPeripheral!.delegate = nil
                self.selectedPeripheral = nil                
            }
        }
    }
    
    private(set) var selectedServices = [CBService]()
    var services: [CBService] {
        get {
            return self.selectedServices
        }
        set {
            self.selectedServices = newValue
            for service in self.selectedServices {
                self.selectedPeripheral?.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    private(set) var selectedCharacteristics = [CBCharacteristic]()
    var characteristics: [CBCharacteristic] {
        get {
            return self.selectedCharacteristics
        }
        set {
            self.selectedCharacteristics = newValue
            let uuids = self.selectedCharacteristics.flatMap({$0.uuid})
            for service in self.selectedServices {
                self.selectedPeripheral!.discoverCharacteristics(uuids, for: service)
            }
        }
    }
    
    var connectedPeripherals: [CBPeripheral]? {
        guard _manager != nil else {
            return [CBPeripheral]()
        }
        return _manager?.retrieveConnectedPeripherals(withServices: AmazfitDefaultServices.getInstance().getCBUUIDs())
//        return _manager?.retrieveConnectedPeripherals(withServices: [GattServices.UUID_SERVICE_DEVICE_INFORMATION.cbuuid])
    }
    private(set) var connectedServices: [CBService]?
    
    static private var instance : BluetoothManager {
        return sharedInstance
    }
    
    private static let sharedInstance = BluetoothManager()
    
    private override init() {
        super.init()
        initCBCentralManager()
    }
    
    func initCBCentralManager() {
        var dic : [String : Any] = Dictionary()
        dic[CBCentralManagerOptionShowPowerAlertKey] = false
        _manager = CBCentralManager(delegate: self, queue: nil, options: dic)

    }
    
    static func getInstance() -> BluetoothManager {
        return instance
    }
    
    //var peripheralManager: CBPeripheralManager?
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        Utils.log("peripheralManagerDidUpdateState", from: classForCoder, args: nil)
        //self.peripheralManager?.startAdvertising([CBAdvertisementDataLocalNameKey: UIDevice.current.name])
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOff {
            Utils.log("CoreBluetooth BLE hardware is powered off", args: nil)
        }
        else if central.state == .poweredOn {
            Utils.log("CoreBluetooth BLE hardware is powered on and ready", args: nil)
            //self.peripheralManager = CBPeripheralManager.init(delegate: self, queue: nil)
        }
        else if central.state == .unauthorized {
            print("CoreBluetooth BLE state is unauthorized")
        }
        else if central.state == .unknown {
            print("CoreBluetooth BLE state is unknown")
        }
        else if central.state == .unsupported {
            print("CoreBluetooth BLE hardware is unsupported on this platform")
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        Utils.log("didConnect peripheral event", from: classForCoder, args: ["Name": (peripheral.name)!, "inentifier":peripheral.identifier])
        bluetoothDelegate?.didConnectedPeripheral?(peripheral)
        self.selectedPeripheral?.discoverServices(nil)

//        ANCS fix later
//        self.appDelegate.peripheralManager = PeripheralManager.init(withUID: "Amazfit Bip")
//        self.appDelegate.peripheralManager?.startAdvertising()
//
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        Utils.log("didDiscoverServices event", from: classForCoder, args: ["Services": peripheral.services!])
        self.selectedServices = peripheral.services!
        bluetoothDelegate?.didDiscoverServices?(peripheral)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        //self.selectedCharacteristics += service.characteristics!
        Utils.log("didDiscoverCharacteristicsFor event", from: classForCoder, args: ["Name": service, "chars": (service.characteristics)!])
        bluetoothDelegate?.didDiscoverCharacteritics?(service)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        //Utils.log("didDiscoverDescriptorsFor event", from: classForCoder, args: ["characteristic": characteristic, "descriptor": (characteristic.descriptors)!])
        bluetoothDelegate?.didDiscoverDescriptors?(characteristic)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        //Utils.log("didUpdateValueFor event", from: classForCoder, args: ["characteristic": characteristic, "value": (characteristic.value)!])
        bluetoothDelegate?.didReadValueForCharacteristic?(characteristic)
    }
    
    func discoverServices(cbuuid: [CBUUID]) {
        Utils.log("discoverService delegate", from: classForCoder, args: nil)
        self.selectedPeripheral?.discoverServices(cbuuid)
    }
    
    func discoverCharacteristics(cbuuid: [CBUUID], service: CBService) {
        Utils.log("discoverCharacteristic delegate", from: classForCoder, args: nil)
        self.selectedPeripheral?.discoverCharacteristics(cbuuid, for: service)
    }
    
    func queryBattInfo() {
        Utils.log("discoverService queryBattInfo", from: classForCoder, args: nil)
        if let ss = self.selectedPeripheral?.services {
            for s in ss {
                if let cc = s.characteristics {
                    for c in cc {
                        if c.uuid == GattCharacteristics.UUID_CHARACTERISTIC_6_BATTERY_INFO.cbuuid {
                            self.selectedPeripheral?.readValue(for: c)
                        }
                    }
                }
            }
        }                        
    }
}
