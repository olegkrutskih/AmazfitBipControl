//
//  DiscoveryCharacteristicsTableViewController.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 21.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit
import CoreBluetooth

class DiscoveryCharacteristicsTableViewController: UITableViewController, BluetoothDelegate {
    var service: CBService?
    var characteristics = [CBCharacteristic]()
    fileprivate let bluetoothManager = BluetoothManager.getInstance()
    var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//    var refreshCtrl: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action:
//            #selector(DiscoveryCharacteristicsTableViewController.handleRefresh(_:)),
//                                 for: UIControlEvents.valueChanged)
//        refreshControl.tintColor = UIColor.red
//
//        return refreshControl
//    }()

    
//    func handleRefresh(_ refreshControl: UIRefreshControl) {
//
//        let newHotel = Hotels(name: "Montage Laguna Beach", place:
//            "California south")
//        hotels.append(newHotel)
//
//        hotels.sort() { $0.name < $0.place }
//
//        self.tableView.reloadData()
//        refreshControl.endRefreshing()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bluetoothManager.bluetoothDelegate = self
        
        //tableView.refreshControl?.addTarget(self, action: #selector(DiscoveryCharacteristicsTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.addTarget(self, action:
            #selector(DiscoveryCharacteristicsTableViewController.handleRefresh(_:)),
                                            for: UIControlEvents.valueChanged)
        tableView.refreshControl!.tintColor = UIColor.blue
//        tableView.refreshControl!.beginRefreshing()
//        tableView.setContentOffset(CGPoint(x: 0, y: -tableView.refreshControl!.frame.size.height), animated: true)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if self.service != nil {
            self.bluetoothManager.services = [self.service!]
        }
        
//        let dispatchQueue = DispatchQueue(label: "Dispatch Queue", attributes: [], target: nil)
//        dispatchQueue.async {
//            Thread.sleep(forTimeInterval: 3)
//            self.tableView.refreshControl!.endRefreshing()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //willTableReloadStart()

    }
    
//    func didConnectedPeripheral(_ connectedPeripheral: CBPeripheral) {
//        Utils.log("didConnectedPeripheral", from: classForCoder, args: ["device": connectedPeripheral])
//        if let srvs = connectedPeripheral.services {
//            self.services.removeAll()
//            self.services += srvs
//        }
//        tableView.reloadData()
//    }
    
//    func willTableReloadStart() {
//        tableView.backgroundView = activityIndicatorView
//
//        let dispatchQueue = DispatchQueue(label: "Dispatch Queue", attributes: [], target: nil)
//        tableView.separatorStyle = .none
//
//        activityIndicatorView.startAnimating()
//
//        dispatchQueue.async {
//            Thread.sleep(forTimeInterval: 3)
//            OperationQueue.main.addOperation() {
//                if self.service != nil {
//                    self.bluetoothManager.services = [self.service!]
//                }
//
//            }
//        }
//
//    }
    
//    func didTableReloadEnded() {
//        self.tableView.separatorStyle = .singleLine
//        self.activityIndicatorView.stopAnimating()
//        tableView.reloadData()
////        tableView
//    }
    
    
    func didDiscoverCharacteritics(_ service: CBService) {
        Utils.log("didDiscoverCharacteritics", from: classForCoder, args: ["service": service])
        if let chars = service.characteristics {
            self.characteristics.removeAll()
            self.characteristics += chars
        }
//        didTableReloadEnded()
        tableView.reloadData()
        tableView.refreshControl!.endRefreshing()
    }
    
//    func didDiscoverServices(_ peripheral: CBPeripheral) {
//        Utils.log("didDiscoverServices", from: classForCoder, args: ["device": peripheral])
//        if let srvs = peripheral.services {
//            self.services.removeAll()
//            self.services += srvs
//        }
//        tableView.reloadData()
//    }
    
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
        return self.characteristics.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characteristicCell", for: indexPath) as! ServicesTableViewCell
        cell.name!.text = AmazfitDefaultCharacteristic.getInstance().getHumanNameByValue(val: self.characteristics[indexPath.row].uuid)
        cell.uuid!.text = self.characteristics[indexPath.row].uuid.uuidString
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

