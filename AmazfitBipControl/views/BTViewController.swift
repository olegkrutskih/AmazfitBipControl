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
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOff {
            Utils.log("CoreBluetooth BLE hardware is powered off", args: nil)
        }
        else if central.state == .poweredOn {
            Utils.log("CoreBluetooth BLE hardware is powered on and ready", args: nil)
            self.amazfitPeripheral!.delegate = self
            self.centralManager!.connect(self.amazfitPeripheral!, options:nil)
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

    override func viewDidLoad() {
        super.viewDidLoad()

        initBT()
    }
    
    func initBT(){
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil)
        //self.amazfitPeripheral = self.centralManager!.retrieveConnectedPeripherals(withServices: services)[0]
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
