//
//  Service.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 18.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation
import CoreBluetooth

struct DefaultService {
    var value: CBUUID
    var isActive: Bool
    var humanName: String
}

struct DefaultCharacteristic {
    var value: CBUUID
    var isActive: Bool
    var humanName: String
}
