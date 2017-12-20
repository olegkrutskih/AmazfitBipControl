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

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var bluetoothDelegate: BluetoothDelegate?
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var _manager: CBCentralManager?
    private(set) var connected = false
    var state: CBManagerState? {
        guard _manager != nil else {
            return nil
        }
        return CBManagerState(rawValue: (_manager?.state.rawValue)!)
    }
    private let notificationCenter = NotificationCenter.default
    private var isConnecting = false
    
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
        return _manager?.retrieveConnectedPeripherals(withServices: appDelegate.amazfitServices!.getCBUUIDs())
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
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOff {
            Utils.log("CoreBluetooth BLE hardware is powered off", args: nil)
        }
        else if central.state == .poweredOn {
            Utils.log("CoreBluetooth BLE hardware is powered on and ready", args: nil)
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
        Utils.log("didConnect peripheral event", args: ["Name": (peripheral.name)!, "inentifier":peripheral.identifier])
        bluetoothDelegate?.didConnectedPeripheral?(peripheral)
        self.selectedPeripheral?.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        self.selectedServices = peripheral.services!
        bluetoothDelegate?.didDiscoverServices?(peripheral)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        //self.selectedCharacteristics += service.characteristics!
        bluetoothDelegate?.didDiscoverCharacteritics?(service)
    }
    
    
    
}
