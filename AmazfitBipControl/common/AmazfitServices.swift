//
//  AmazfitServices.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 18.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//
//part of the generic BLE specs see https://developer.bluetooth.org/gatt/services/Pages/ServicesHome.aspx
//the list is complete as of 2015-09-28

import Foundation
import CoreBluetooth

class AmazfitServices {
    var services = [String: Service]()
    private let BASE_UUID = "0000%s-0000-1000-8000-00805f9b34fb"
    
    init() {
        self.services["UUID_SERVICE_MIBAND_SERVICE"] = Service(value: getUUIDFromBase(pieceUUID: "FEE0"), isActive: false)
        self.services["UUID_SERVICE_MIBAND2_SERVICE"] = Service(value: getUUIDFromBase(pieceUUID: "FEE1"), isActive: false)
        self.services["UUID_SERVICE_FIRMWARE_SERVICE"] = Service(value: CBUUID.init(string: "00001530-0000-3512-2118-0009af100700"), isActive: false)

        self.services["UUID_SERVICE_ALERT_NOTIFICATION"] = Service(value: getUUIDFromBase(pieceUUID: "1811"), isActive: false)
        self.services["UUID_SERVICE_AUTOMATION_IO"] = Service(value: getUUIDFromBase(pieceUUID: "1815"), isActive: false)
        self.services["UUID_SERVICE_BATTERY_SERVICE"] = Service(value: getUUIDFromBase(pieceUUID: "180F"), isActive: false)
        self.services["UUID_SERVICE_BLOOD_PRESSURE"] = Service(value: getUUIDFromBase(pieceUUID: "1810"), isActive: false)
        self.services["UUID_SERVICE_BODY_COMPOSITION"] = Service(value: getUUIDFromBase(pieceUUID: "181B"), isActive: false)
        self.services["UUID_SERVICE_BOND_MANAGEMENT"] = Service(value: getUUIDFromBase(pieceUUID: "181E"), isActive: false)
        self.services["UUID_SERVICE_CONTINUOUS_GLUCOSE_MONITORING"] = Service(value: getUUIDFromBase(pieceUUID: "181F"), isActive: false)
        self.services["UUID_SERVICE_CURRENT_TIME"] = Service(value: getUUIDFromBase(pieceUUID: "1805"), isActive: false)
        self.services["UUID_SERVICE_CYCLING_POWER"] = Service(value: getUUIDFromBase(pieceUUID: "1818"), isActive: false)
        self.services["UUID_SERVICE_CYCLING_SPEED_AND_CADENCE"] = Service(value: getUUIDFromBase(pieceUUID: "1816"), isActive: false)
        self.services["UUID_SERVICE_DEVICE_INFORMATION"] = Service(value: getUUIDFromBase(pieceUUID: "180A"), isActive: false)
        self.services["UUID_SERVICE_ENVIRONMENTAL_SENSING"] = Service(value: getUUIDFromBase(pieceUUID: "181A"), isActive: false)
        self.services["UUID_SERVICE_GENERIC_ACCESS"] = Service(value: getUUIDFromBase(pieceUUID: "1801"), isActive: false)
        self.services["UUID_SERVICE_GLUCOSE"] = Service(value: getUUIDFromBase(pieceUUID: "1808"), isActive: false)
        self.services["UUID_SERVICE_HEALTH_THERMOMETER"] = Service(value: getUUIDFromBase(pieceUUID: "1809"), isActive: false)
        self.services["UUID_SERVICE_HEART_RATE"] = Service(value: getUUIDFromBase(pieceUUID: "180D"), isActive: false)
        self.services["UUID_SERVICE_HUMAN_INTERFACE_DEVICE"] = Service(value: getUUIDFromBase(pieceUUID: "1812"), isActive: false)
        self.services["UUID_SERVICE_IMMEDIATE_ALERT"] = Service(value: getUUIDFromBase(pieceUUID: "1802"), isActive: false)
        self.services["UUID_SERVICE_INDOOR_POSITIONING"] = Service(value: getUUIDFromBase(pieceUUID: "1821"), isActive: false)
        self.services["UUID_SERVICE_INTERNET_PROTOCOL_SUPPORT"] = Service(value: getUUIDFromBase(pieceUUID: "1820"), isActive: false)
        self.services["UUID_SERVICE_LINK_LOSS"] = Service(value: getUUIDFromBase(pieceUUID: "1803"), isActive: false)
        self.services["UUID_SERVICE_LOCATION_AND_NAVIGATION"] = Service(value: getUUIDFromBase(pieceUUID: "1819"), isActive: false)
        self.services["UUID_SERVICE_NEXT_DST_CHANGE"] = Service(value: getUUIDFromBase(pieceUUID: "1807"), isActive: false)
        self.services["UUID_SERVICE_PHONE_ALERT_STATUS"] = Service(value: getUUIDFromBase(pieceUUID: "180E"), isActive: false)
        self.services["UUID_SERVICE_PULSE_OXIMETER"] = Service(value: getUUIDFromBase(pieceUUID: "1822"), isActive: false)
        self.services["UUID_SERVICE_REFERENCE_TIME_UPDATE"] = Service(value: getUUIDFromBase(pieceUUID: "1806"), isActive: false)
        self.services["UUID_SERVICE_RUNNING_SPEED_AND_CADENCE"] = Service(value: getUUIDFromBase(pieceUUID: "1814"), isActive: false)
        self.services["UUID_SERVICE_SCAN_PARAMETERS"] = Service(value: getUUIDFromBase(pieceUUID: "1813"), isActive: false)
        self.services["UUID_SERVICE_TX_POWER"] = Service(value: getUUIDFromBase(pieceUUID: "1804"), isActive: false)
        self.services["UUID_SERVICE_USER_DATA"] = Service(value: getUUIDFromBase(pieceUUID: "181C"), isActive: false)
        self.services["UUID_SERVICE_WEIGHT_SCALE"] = Service(value: getUUIDFromBase(pieceUUID: "181D"), isActive: false)
    }
    
    func getUUIDFromBase(pieceUUID: String) -> CBUUID {
        let fullUUID = BASE_UUID.replacingOccurrences(of: "%s", with: pieceUUID)
        return CBUUID.init(string: fullUUID)
    }

}


