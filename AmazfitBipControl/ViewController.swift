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
//    var connected: String
//    var bodyData: String
//    var manufacturer: String
    var amazfitDeviceData: String?
    //var heartRate: UInt16
    var pulseTimer: Timer?
    var heartRateBPM1: UILabel?
    
    @IBOutlet weak var heartRateBPM: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // Determine the state of the peripheral
        if central.state == .poweredOff {
            print("CoreBluetooth BLE hardware is powered off")
        }
        else if central.state == .poweredOn {
            print("CoreBluetooth BLE hardware is powered on and ready")
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
        //
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        //
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let localName: String = advertisementData[CBAdvertisementDataLocalNameKey] as! String
        if localName.count > 0 {
            print("Found the heart rate monitor: \(localName)")
            self.centralManager!.stopScan()
            self.amazfitPeripheral = peripheral
            peripheral.delegate = self
            self.centralManager!.connect(peripheral, options:nil)
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
        
        let services: [CBUUID] = [AmazfitBipService.UUID_SERVICE_MIBAND2_SERVICE, GattService.UUID_SERVICE_HEART_RATE, GattService.UUID_SERVICE_DEVICE_INFORMATION]
        
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil)
        self.centralManager!.scanForPeripherals(withServices: services, options: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

