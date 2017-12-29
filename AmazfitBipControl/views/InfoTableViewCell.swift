//
//  InfoTableViewCell.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 28.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit
import CoreBluetooth

class InfoTableViewCell: UITableViewCell, BluetoothDelegate {

    @IBOutlet weak var batteryImage: UIImageView!
    @IBOutlet weak var batteryLabel: UILabel!
    
    var dataQueryDelegate: DataQueryDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        BluetoothManager.getInstance().bluetoothDelegate = self
        dataQueryDelegate = BluetoothManager.getInstance()
        Utils.log("awakeFromNib", from: classForCoder, args: nil)
        dataQueryDelegate?.discoverServices?(cbuuid: [GattCharacteristics.UUID_CHARACTERISTIC_6_BATTERY_INFO.cbuuid])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func didDiscoverCharacteritics(_ service: CBService) {
        Utils.log("didDiscoverCharacteritics", from: classForCoder, args: ["service": service])
        if service.uuid == GattServices.UUID_SERVICE_BATTERY_SERVICE.cbuuid {
//            dataQueryDelegate?.queryBattInfo?()
            if let cc = service.characteristics {
                for c in cc {
                    if c.uuid == GattCharacteristics.UUID_CHARACTERISTIC_6_BATTERY_INFO.cbuuid {
                        let batt = AmazfitNotifyReaderSupport.readBatteryLevel(data: c.value)
                        updateCell(batt: batt)
                    }
                }
            }
            
        }
    }
    
    func updateCell(batt: Int) {
        var img: UIImage = #imageLiteral(resourceName: "b101")
        
        if batt < 100 {
            img = #imageLiteral(resourceName: "b80")
        }
        if batt < 80 {
            img = #imageLiteral(resourceName: "b60")
        }
        if batt < 60 {
            img = #imageLiteral(resourceName: "b40")
        }
        if batt < 40 {
            img = #imageLiteral(resourceName: "b20")
        }
        if batt < 20 {
            img = #imageLiteral(resourceName: "b10")
        }
        if batt < 10 {
            img = #imageLiteral(resourceName: "b0")
        }
        
        batteryImage.image = img
        batteryLabel.text = "Battery level \(batt)%."
    }
    
    func didDiscoverServices(_ peripheral: CBPeripheral) {
        Utils.log("didDiscoverServices", from: classForCoder, args: ["service": peripheral.services])
        if let s = peripheral.services!.first(where: {$0.uuid == GattServices.UUID_SERVICE_BATTERY_SERVICE.cbuuid}) {
            dataQueryDelegate?.discoverCharacteristics?(cbuuid: [GattCharacteristics.UUID_CHARACTERISTIC_6_BATTERY_INFO.cbuuid], service: s)
        }
    }

    func didReadValueForCharacteristic(_ characteristic: CBCharacteristic) {
        Utils.log("didReadValueForCharacteristic", from: classForCoder, args: ["characteristic": characteristic])
        if characteristic.value != nil && characteristic.value!.count != 0 {
            if characteristic.uuid == GattCharacteristics.UUID_CHARACTERISTIC_6_BATTERY_INFO.cbuuid {
                let batt = AmazfitNotifyReaderSupport.readBatteryLevel(data: characteristic.value)
                
                updateCell(batt: batt)
                
            }
        }
    }
    
}
