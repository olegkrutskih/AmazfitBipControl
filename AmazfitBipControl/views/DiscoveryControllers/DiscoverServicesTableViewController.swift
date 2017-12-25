//
//  DiscoverServicesTableViewController.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 20.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit
import CoreBluetooth

class DiscoverServicesTableViewController: UITableViewController, BluetoothDelegate {
    var device: CBPeripheral?
    var services = [CBService]()
    fileprivate let bluetoothManager = BluetoothManager.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bluetoothManager.bluetoothDelegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.device != nil {
            bluetoothManager.peripferal = self.device
        }
    }
    
    func didConnectedPeripheral(_ connectedPeripheral: CBPeripheral) {
        Utils.log("didConnectedPeripheral", from: classForCoder, args: ["device": connectedPeripheral])
        if let srvs = connectedPeripheral.services {
            self.services.removeAll()
            self.services += srvs
        }
        tableView.reloadData()
    }
    
    func didDiscoverServices(_ peripheral: CBPeripheral) {
        Utils.log("didDiscoverServices", from: classForCoder, args: ["device": peripheral])
        if let srvs = peripheral.services {
            self.services.removeAll()
            self.services += srvs
        }
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
        return self.services.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell", for: indexPath) as! ServicesTableViewCell
        cell.name!.text = AmazfitDefaultServices.getInstance().getHumanNameByValue(val: self.services[indexPath.row].uuid) // self.defaultServicesNumberedArray[indexPath.row]
        cell.uuid!.text = self.services[indexPath.row].uuid.uuidString
        cell.service = self.services[indexPath.row]
//        let isActive = self.services[indexPath.row].isActive
  //      cell.isActive.setOn(isActive, animated: false)
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
        let destView = segue.destination as! DiscoveryCharacteristicsTableViewController
        let cell = sender as! ServicesTableViewCell
        destView.service = cell.service
    }
    

}
