//
//  BTViewController.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 18.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit
import CoreBluetooth

class BTViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager?
    var amazfitPeripheral: CBPeripheral?
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func connect(_ sender: UIButton) {
        self.amazfitPeripheral = nil
        self.centralManager = nil
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil)
        self.amazfitPeripheral = self.centralManager!.retrieveConnectedPeripherals(withServices: appDelegate.amazfitServices!.getCBUUIDs())[0]
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOff {
            Utils.log("CoreBluetooth BLE hardware is powered off", args: nil)
        }
        else if central.state == .poweredOn {
            Utils.log("CoreBluetooth BLE hardware is powered on and ready", args: nil)
            self.amazfitPeripheral!.delegate = self
            self.centralManager!.connect(self.amazfitPeripheral!, options:nil)
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
        self.amazfitPeripheral?.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        Utils.log("didDisconnectPeripheral event", args: nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        Utils.log("didDiscoverServices event", args: nil)
        for service in peripheral.services! {
            let thisService = service as CBService
            Utils.log("service", args: ["Name": self.appDelegate.amazfitServices!.getHumanNameByValue(val: service.uuid)])
            peripheral.discoverCharacteristics(nil, for: thisService)            
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        Utils.log("didDiscoverCharacteristicsFor service event", args: ["service": self.appDelegate.amazfitServices!.getHumanNameByValue(val: service.uuid)])
        
        for characteristic in (service.characteristics)! {
            Utils.log("characteristic", args: ["Name": self.appDelegate.amazfitCharacteristic!.getHumanNameByValue(val: characteristic.uuid)])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //initBT()
    }
    
    func initBT(){
        Utils.log("initBT", args: nil)
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil)
        self.amazfitPeripheral = self.centralManager!.retrieveConnectedPeripherals(withServices: appDelegate.amazfitServices!.getCBUUIDs())[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
