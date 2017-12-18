//
//  ViewController.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 14.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager: CBCentralManager?
    var amazfitPeripheral: CBPeripheral?
    var amazfitNotify: CBCharacteristic?
//    var connected: String
//    var bodyData: String
//    var manufacturer: String
    var amazfitDeviceData: String?
    //var heartRate: UInt16
    var pulseTimer: Timer?
    var characteristics: [CBCharacteristic] = []

    var heartRateBPM1: UILabel? 
    
    let services: [CBUUID] = [
        AmazfitBipService.UUID_SERVICE_MIBAND2_SERVICE,
        AmazfitBipService.UUID_SERVICE_HEART_RATE,
        AmazfitBipService.UUID_SERVICE_FIRMWARE_SERVICE//,
//        GattService.UUID_SERVICE_ALERT_NOTIFICATION,
//        GattService.UUID_SERVICE_IMMEDIATE_ALERT,
//        GattService.UUID_SERVICE_GENERIC_ACCESS,
//        GattService.UUID_SERVICE_GENERIC_ATTRIBUTE,
//        GattService.UUID_SERVICE_HEART_RATE,
//        GattService.UUID_SERVICE_DEVICE_INFORMATION,
//        //AmazfitBipService.UUID_CHARACTERISTIC_BATTERY,
//        GattService.UUID_SERVICE_PHONE_ALERT_STATUS
        
    ] + GattService.getGattServices()
    
    @IBOutlet weak var heartRateBPM: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var buttonRing: UIButton!
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // Determine the state of the peripheral
        if central.state == .poweredOff {
            print("CoreBluetooth BLE hardware is powered off")
            
        }
        else if central.state == .poweredOn {
            print("CoreBluetooth BLE hardware is powered on and ready")
            self.amazfitPeripheral!.delegate = self
            self.centralManager!.connect(self.amazfitPeripheral!, options:nil)
            //amazfitPeripheral!.
            print(self.amazfitPeripheral!)
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
        print("didConnect peripheral \(peripheral)")
        self.amazfitPeripheral?.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("didDisconnectPeripheral")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("didDiscover peripheral")
        let localName: String = advertisementData[CBAdvertisementDataLocalNameKey] as! String
        if localName.count > 0 {
            print("Found the heart rate monitor: \(localName)")
            self.centralManager!.stopScan()
            self.amazfitPeripheral = peripheral
            peripheral.delegate = self
            self.centralManager!.connect(peripheral, options:nil)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("didUpdateValueFor characteristic: \(characteristic)")
        
        //if characteristic.uuid == AmazfitBipService.UUID_BATT_INFO || characteristic.uuid == AmazfitBipService.UUID_3 {
            let data = characteristic.value
        if data != nil {
            var bytes = Array(repeating: 0 as UInt8, count:data!.count/MemoryLayout<UInt8>.size)
            data!.copyBytes(to: &bytes, count:data!.count)
            
//            let b_data: UnsafePointer<UInt8>
//            try data?.withUnsafeBytes(b_data)
            print("=======Value for ch \(characteristic.uuid): \(bytes)=======")

            if characteristic.uuid == AmazfitBipService.UUID_STEPS {
                var steps = Array(repeating: 0 as UInt8, count:2)
                steps.insert(data![1], at: 0)
                steps.insert(data![2], at: 1)
                var value : UInt32 = 0
                let data1 = NSData(bytes: steps, length: 2)
                data1.getBytes(&value, length: 2)
                let ssteps = UInt32(bigEndian: value)
                
//                let data1 = Data(bytes: steps)
//                let ssteps = UInt32(bigEndian: data1.withUnsafeBytes { $0.pointee })
//                ssteps = UInt16( (bigEndian: data1.withUnsafeBytes { $0.pointee })
                
//                let ssteps = (steps[0] & 0xFF) | ((steps[1] & 0xFF) << 8)
                print("------ STEPS: \(ssteps)")
            }
            
            
            
        }
        //}
        
        if AmazfitBipService.getUUIDS().contains(characteristic.uuid) {
            print("didUpdateValueFor UUIDS: \(characteristic)")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("didWriteValueFor characteristic")
        
//        if characteristic.uuid == AmazfitBipService.UUID_CONFIG {
            print("------ CONFIG: \(characteristic)")
//        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices")
        for service in peripheral.services! {
            let thisService = service as CBService
            
            print("service: \(service.uuid), \(service.characteristics)")
            peripheral.discoverCharacteristics(nil, for: thisService)
            
        
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("didDiscoverCharacteristicsFor")
        //print("peripheral: \(peripheral.uuid.uuidString)")
        print("service: \(service.uuid.uuidString)")
        for c in service.characteristics! {
            let charact = c as CBCharacteristic
            
            print("characteristics: \(charact.uuid)")
            //if service.uuid == AmazfitBipService.UUID_SERVICE_MIBAND2_SERVICE {
                
                self.characteristics.append(charact)
                //print("AmazfitBipService.UUID_SERVICE_MIBAND2_SERVICE, append charact: \(self.characteristics)")
            //}
//            if charact.uuid == GattCharacteristic.UUID_CHARACTERISTIC_NEW_ALERT {
//                self.amazfitNotify = charact
////                print("didDiscoverCharacteristicsFor::send test")
////                let data = "test".data(using: String.Encoding.utf8)
////                self.amazfitPeripheral!.writeValue(data!, for: charact, type: CBCharacteristicWriteType.withResponse)
//            }
        
        }
    }
    
    
    func getHeartBPMData(characteristic: CBCharacteristic) throws {
        
    }
    
    func getManufacturerName(characteristic: CBCharacteristic) {
        
    }
    
    func getBodyLocation(characteristic: CBCharacteristic){
        
    }
    
    func doHeartBeat() {
        
    }

    @IBAction func dingDong() {
//        self.amazfitPeripheral?.writeValue(<#T##data: Data##Data#>, for: <#T##CBCharacteristic#>, type: <#T##CBCharacteristicWriteType#>)
        print("dingDong::send test")
        let data = "test!".data(using: String.Encoding.utf8)
        
        //self.amazfitPeripheral!.writeValue(data!, for: self.amazfitNotify!, type: CBCharacteristicWriteType.withResponse)
        
        for ch in self.characteristics {
            if ch.uuid == AmazfitBipService.UUID_BATT_INFO {
                //self.amazfitPeripheral!.writeValue(data!, for: ch, type: CBCharacteristicWriteType.withResponse)
                self.amazfitPeripheral!.readValue(for: ch)
            }
            if AmazfitBipService.getUUIDS().contains(ch.uuid) {
                self.amazfitPeripheral!.readValue(for: ch)
            }
            
            if ch.uuid == AmazfitBipService.UUID_CONFIG {
                let dt: Data = Data.init(bytes: AmazfitBipService.COMMAND_REQUEST_GPS_VERSION)
                self.amazfitPeripheral!.writeValue(dt, for: ch, type: .withResponse)
            }
            
            if ch.uuid == GattCharacteristic.UUID_CHARACTERISTIC_NEW_ALERT {
                let msg: [UInt8] = [toUInt8(-6),toUInt8(1), toUInt8(0)] + strToUInt8("Hello world!")
                let dt: Data = Data.init(bytes: msg)
                self.amazfitPeripheral!.writeValue(dt, for: ch, type: .withResponse)
            }
       }
        
        
    }
    
    func toUInt8(_ i: Int) -> UInt8{
        return UInt8(bitPattern: Int8(i))
    }
    
    func strToUInt8(_ s: String) -> [UInt8] {
        var byteArray = [UInt8]()
        for char in s.utf8{
            byteArray += [char]
        }
        return byteArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.amazfitDeviceData = nil;
        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.imageView.image = UIImage.init(imageLiteralResourceName: "HeartImage")
        
        // Clear out textView
        self.textView.text = ""
        self.textView.textColor = UIColor.blue
        self.textView.backgroundColor = UIColor.groupTableViewBackground
        self.textView.font = UIFont.init(name: "Futura-CondensedMedium", size: 25)
        self.textView.isUserInteractionEnabled = true
        
        // Create your Heart Rate BPM Label
        self.heartRateBPM1 = UILabel.init(frame: CGRect.init(x: 55, y: 30, width: 75, height: 50))
        self.heartRateBPM1?.textColor = UIColor.white
        self.heartRateBPM1?.text = String.init(format: "%i", [0])
        self.heartRateBPM1?.font = UIFont.init(name: "Futura-CondensedMedium", size: 28)
        self.imageView.addSubview(self.heartRateBPM1!)
        
        // Scan for all available CoreBluetooth LE devices
        
        
        
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil)
        //self.centralManager!.scanForPeripherals(withServices: nil, options: nil)
        print(self.centralManager!.retrieveConnectedPeripherals(withServices: services))
        self.amazfitPeripheral = self.centralManager!.retrieveConnectedPeripherals(withServices: services)[0]
        //print(self.amazfitPeripheral?.discoverServices(nil))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


