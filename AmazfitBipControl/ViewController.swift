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

    var heartRateBPM1: UILabel? 
    
    let services: [CBUUID] = [
        AmazfitBipService.UUID_SERVICE_MIBAND2_SERVICE,
        AmazfitBipService.UUID_SERVICE_HEART_RATE,
        AmazfitBipService.UUID_SERVICE_FIRMWARE_SERVICE,
        GattService.UUID_SERVICE_ALERT_NOTIFICATION,
        GattService.UUID_SERVICE_IMMEDIATE_ALERT
//        GattService.UUID_SERVICE_HEART_RATE,
//        GattService.UUID_SERVICE_DEVICE_INFORMATION,
//        AmazfitBipService.UUID_CHARACTERISTIC_BATTERY
    ]
    
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
        print("didConnect peripheral")
        self.amazfitPeripheral?.discoverServices(services)
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
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("didWriteValueFor characteristic")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices")
        for service in peripheral.services! {
            let thisService = service as CBService
            
            print("peripheral: \(service.uuid), \(service.characteristics)")
            peripheral.discoverCharacteristics(nil, for: thisService)
            
        
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("didDiscoverCharacteristicsFor")
        for c in service.characteristics! {
            let charact = c as CBCharacteristic
            print("characteristics: \(charact.uuid.uuidString)")
            
            if charact.uuid == GattCharacteristic.UUID_CHARACTERISTIC_NEW_ALERT {
                self.amazfitNotify = charact
                print("didDiscoverCharacteristicsFor::send test")
                let data = "test".data(using: String.Encoding.utf8)
                self.amazfitPeripheral!.writeValue(data!, for: charact, type: CBCharacteristicWriteType.withResponse)
            }
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
        
        self.amazfitPeripheral!.writeValue(data!, for: self.amazfitNotify!, type: CBCharacteristicWriteType.withResponse)
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

