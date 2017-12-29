//
//  GattServices.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 29.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation
import CoreBluetooth

enum GattServices: String {
    
    // Unknown
    case UUID_SERVICE_MIBAND2_SERVICE = "FEE1"
    
    // Proprietary Xiaomi services
    case UUID_SERVICE_XIAOMI_MILI = "FEE0"
    case UUID_SERVICE_XIAOMI_FIRMWARE_SERVICE = "1530"
    case UUID_SERVICE_XIAOMI_HPLUS = "14701820-620a-3973-7c78-9cfff0876abd"
    
    // Standart services
    case UUID_SERVICE_ALERT_NOTIFICATION = "1811"
    case UUID_SERVICE_AUTOMATION_IO = "1815"
    case UUID_SERVICE_BATTERY_SERVICE = "180F"
    case UUID_SERVICE_BLOOD_PRESSURE = "1810"
    case UUID_SERVICE_BODY_COMPOSITION = "181B"
    case UUID_SERVICE_BOND_MANAGEMENT = "181E"
    case UUID_SERVICE_CONTINUOUS_GLUCOSE_MONITORING = "181F"
    case UUID_SERVICE_CURRENT_TIME = "1805"
    case UUID_SERVICE_CYCLING_POWER = "1818"
    case UUID_SERVICE_CYCLING_SPEED_AND_CADENCE = "1816"
    case UUID_SERVICE_DEVICE_INFORMATION = "180A"
    case UUID_SERVICE_ENVIRONMENTAL_SENSING = "181A"
    case UUID_SERVICE_GENERIC_ACCESS = "1800"
    case UUID_SERVICE_GENERIC_ACCESS1 = "1801"
    case UUID_SERVICE_GLUCOSE = "1808"
    case UUID_SERVICE_HEALTH_THERMOMETER = "1809"
    case UUID_SERVICE_HEART_RATE = "180D"
    case UUID_SERVICE_HUMAN_INTERFACE_DEVICE = "1812"
    case UUID_SERVICE_IMMEDIATE_ALERT = "1802"
    case UUID_SERVICE_INDOOR_POSITIONING = "1821"
    case UUID_SERVICE_INTERNET_PROTOCOL_SUPPORT = "1820"
    case UUID_SERVICE_LINK_LOSS = "1803"
    case UUID_SERVICE_LOCATION_AND_NAVIGATION = "1819"
    case UUID_SERVICE_NEXT_DST_CHANGE = "1807"
    case UUID_SERVICE_PHONE_ALERT_STATUS = "180E"
    case UUID_SERVICE_PULSE_OXIMETER = "1822"
    case UUID_SERVICE_REFERENCE_TIME_UPDATE = "1806"
    case UUID_SERVICE_RUNNING_SPEED_AND_CADENCE = "1814"
    case UUID_SERVICE_SCAN_PARAMETERS = "1813"
    case UUID_SERVICE_TX_POWER = "1804"
    case UUID_SERVICE_USER_DATA = "181C"
    case UUID_SERVICE_WEIGHT_SCALE = "181D"
    
    var cbuuid: CBUUID { return CBUUID.init(string: self.rawValue) }
    var cbservice: CBService { return CBMutableService.init(type: cbuuid, primary: true) }
    var name: String { return "\(self)" }
    var description: String { return self.getHumanName()}
    
    private func getHumanName() -> String {
        return (self.cbuuid.description == self.rawValue) ? "\(self)".lowercased().split(separator: "_").filter({$0 != "uuid"}).map({ $0.prefix(1).uppercased() + $0.dropFirst() }).joined(separator: " ") : self.cbuuid.description
    }
}
