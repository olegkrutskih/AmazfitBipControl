//
//  BatteryState.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 14.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

public enum BatteryState: String, Codable {
    case UNKNOWN
    case BATTERY_NORMAL
    case BATTERY_LOW
    case BATTERY_CHARGING
    case BATTERY_CHARGING_FULL
    case BATTERY_NOT_CHARGING_FULL
}
