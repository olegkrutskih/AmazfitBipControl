//
//  BTViewController.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 18.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit
import CoreBluetooth

class BTViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, BluetoothDelegate {
    var centralManager: CBCentralManager?
    var amazfitPeripheral: CBPeripheral?
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func connect(_ sender: UIButton) {
        self.amazfitPeripheral = nil
        self.centralManager = nil
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil)
        self.amazfitPeripheral = self.centralManager!.retrieveConnectedPeripherals(withServices: AmazfitDefaultServices.getInstance().getCBUUIDs())[0]
    }
    
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        Utils.log("didConnect peripheral event", from: classForCoder, args: ["Name": (peripheral.name)!, "inentifier":peripheral.identifier])
        self.amazfitPeripheral?.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        Utils.log("didDisconnectPeripheral event", args: nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        Utils.log("didDiscoverServices event", args: nil)
        for service in peripheral.services! {
            let thisService = service as CBService
            Utils.log("service", args: ["Name": AmazfitDefaultServices.getInstance().getHumanNameByValue(val: service.uuid)])
            peripheral.discoverCharacteristics(nil, for: thisService)            
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        Utils.log("didDiscoverCharacteristicsFor service event", args: ["service": AmazfitDefaultServices.getInstance().getHumanNameByValue(val: service.uuid)])
        
        for characteristic in (service.characteristics)! {
            Utils.log("characteristic", args: ["Name": AmazfitDefaultCharacteristic.getInstance().getHumanNameByValue(val: characteristic.uuid)])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getDevices()
        //initBT()
    }
    
    func getDevices() {
        Utils.log("getDevices", args: nil)
        let devices = BluetoothManager.getInstance().connectedPeripherals
        Utils.log("getDevices()", from: self.classForCoder, args: ["devices list": devices])
        
    }
    
    
    func initBT(){
        Utils.log("initBT", args: nil)
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil)
        self.amazfitPeripheral = self.centralManager!.retrieveConnectedPeripherals(withServices: AmazfitDefaultServices.getInstance().getCBUUIDs())[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func showDevicesView() {
        let discoverDevicesTableViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "discoverDevices") as? DiscoverDevicesTableViewController
        self.navigationController?.pushViewController(discoverDevicesTableViewControllerObj!, animated: true)
    }

}
