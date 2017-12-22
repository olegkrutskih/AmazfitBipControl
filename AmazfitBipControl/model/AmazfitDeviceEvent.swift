//
//  AmazfitDeviceEvent.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 22.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

enum AmazfitDeviceEvent: Int {
    case BUTTON_PRESSED = 0x4
    case BUTTON_PRESSED_LONG = 0x0b
    case UNNOWN = 0xff
    
//    public static let EVENTS = [0x04: "BUTTON_PRESSED",
//                                0x0b: "BUTTON_PRESSED_LONG",
//                                0xff: "UNNOWN"]
    
    
}
