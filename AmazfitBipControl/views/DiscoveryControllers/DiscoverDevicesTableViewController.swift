//
//  DiscoverDevicesTableViewController.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 20.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit
import CoreBluetooth

class DiscoverDevicesTableViewController: UITableViewController {
    var devices = [CBPeripheral]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = 95
        tableView.rowHeight = 95
        tableView.estimatedRowHeight = 117
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDevices()
    }
    
    func getDevices() {
        Utils.log("getDevices", args: nil)
        self.devices = BluetoothManager.getInstance().connectedPeripherals!
        Utils.log("getDevices()", from: self.classForCoder, args: ["devices list": devices])
        tableView.reloadData()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return devices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as! DeviceTableViewCell
        cell.deviceImage.frame = CGRect.init(x: 0, y: 0, width: 95, height: 95)
        if self.devices[indexPath.row].name == DefinesConstant.AMAZFIT_BIP_DEVICE_NAME.rawValue {
            cell.deviceImage.image = #imageLiteral(resourceName: "amazfit")
        } else {
            cell.deviceImage.image = #imageLiteral(resourceName: "UnknownDevice")
        }
        cell.deviceName.text = devices[indexPath.row].name
        cell.deviceUUID.text = devices[indexPath.row].identifier.uuidString
        cell.device = self.devices[indexPath.row]
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destView = segue.destination as! DiscoverServicesTableViewController
        let cell = sender as! DeviceTableViewCell
        destView.device = cell.device
    }
 

}
