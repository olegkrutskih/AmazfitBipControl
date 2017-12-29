//
//  DataQueryDelegate.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 28.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation
import CoreBluetooth

@objc protocol DataQueryDelegate: NSObjectProtocol {

    @objc optional func queryBattInfo()
    
    @objc optional func discoverServices(cbuuid: [CBUUID])
    
    @objc optional func discoverCharacteristics(cbuuid: [CBUUID], service: CBService)
    
}
