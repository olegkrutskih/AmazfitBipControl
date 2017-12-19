//
//  AmazfitServices.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 18.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//
// Based on the generic BLE specs see https://www.bluetooth.com/specifications/gatt/services

import Foundation
import CoreBluetooth
import UIKit

class AmazfitServices {

    private let BASE_UUID = "0000%s-0000-1000-8000-00805f9b34fb"
    private let XIAOMI_BASE_UUID = "0000%s-0000-3512-2118-0009af100700"
    var services = [String: Service]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init() {
        Utils.log("AmazfitServices.init", args: nil)
        
        // Unknown
        self.services["UUID_SERVICE_MIBAND_SERVICE"] = Service(value: getUUIDFromBase(pieceUUID: "FEE0"), isActive: false, humanName: "UUID_SERVICE_MIBAND_SERVICE")
        self.services["UUID_SERVICE_MIBAND2_SERVICE"] = Service(value: getUUIDFromBase(pieceUUID: "FEE1"), isActive: false, humanName: "UUID_SERVICE_MIBAND2_SERVICE")
        
        // Proprietary Xiaomi services
        self.services["UUID_SERVICE_XIAOMI_MILI"] = Service(value: getXiaomiUUIDFromBase(pieceUUID: "FEE0"), isActive: false, humanName: "(Propr: Xiaomi MiLi Service)")
        self.services["UUID_SERVICE_XIAOMI_FIRMWARE_SERVICE"] = Service(value: getXiaomiUUIDFromBase(pieceUUID: "1530"), isActive: false, humanName: "(Propr: Xiaomi Weight Service)")
        self.services["UUID_SERVICE_XIAOMI_HPLUS"] = Service(value: CBUUID.init(string: "14701820-620a-3973-7c78-9cfff0876abd"), isActive: false, humanName: "(Propr: HPLUS Service)")

        // Standart services
        self.services["UUID_SERVICE_ALERT_NOTIFICATION"] = Service(value: getUUIDFromBase(pieceUUID: "1811"), isActive: false, humanName: "Alert Notification Service")
        self.services["UUID_SERVICE_AUTOMATION_IO"] = Service(value: getUUIDFromBase(pieceUUID: "1815"), isActive: false, humanName: "Automation IO")
        self.services["UUID_SERVICE_BATTERY_SERVICE"] = Service(value: getUUIDFromBase(pieceUUID: "180F"), isActive: false, humanName: "Battery Service")
        self.services["UUID_SERVICE_BLOOD_PRESSURE"] = Service(value: getUUIDFromBase(pieceUUID: "1810"), isActive: false, humanName: "Blood Pressure")
        self.services["UUID_SERVICE_BODY_COMPOSITION"] = Service(value: getUUIDFromBase(pieceUUID: "181B"), isActive: false, humanName: "Body Composition")
        self.services["UUID_SERVICE_BOND_MANAGEMENT"] = Service(value: getUUIDFromBase(pieceUUID: "181E"), isActive: false, humanName: "Bond Management Service")
        self.services["UUID_SERVICE_CONTINUOUS_GLUCOSE_MONITORING"] = Service(value: getUUIDFromBase(pieceUUID: "181F"), isActive: false, humanName: "Continuous Glucose Monitoring")
        self.services["UUID_SERVICE_CURRENT_TIME"] = Service(value: getUUIDFromBase(pieceUUID: "1805"), isActive: false, humanName: "Current Time Service")
        self.services["UUID_SERVICE_CYCLING_POWER"] = Service(value: getUUIDFromBase(pieceUUID: "1818"), isActive: false, humanName: "Cycling Power")
        self.services["UUID_SERVICE_CYCLING_SPEED_AND_CADENCE"] = Service(value: getUUIDFromBase(pieceUUID: "1816"), isActive: false, humanName: "Cycling Speed and Cadence")
        self.services["UUID_SERVICE_DEVICE_INFORMATION"] = Service(value: getUUIDFromBase(pieceUUID: "180A"), isActive: false, humanName: "Device Information")
        self.services["UUID_SERVICE_ENVIRONMENTAL_SENSING"] = Service(value: getUUIDFromBase(pieceUUID: "181A"), isActive: false, humanName: "Environmental Sensing")
        self.services["UUID_SERVICE_GENERIC_ACCESS"] = Service(value: getUUIDFromBase(pieceUUID: "1800"), isActive: false, humanName: "Generic Access")
        self.services["UUID_SERVICE_GENERIC_ACCESS"] = Service(value: getUUIDFromBase(pieceUUID: "1801"), isActive: false, humanName: "Generic Attribute")
        self.services["UUID_SERVICE_GLUCOSE"] = Service(value: getUUIDFromBase(pieceUUID: "1808"), isActive: false, humanName: "Glucose")
        self.services["UUID_SERVICE_HEALTH_THERMOMETER"] = Service(value: getUUIDFromBase(pieceUUID: "1809"), isActive: false, humanName: "Health Thermometer")
        self.services["UUID_SERVICE_HEART_RATE"] = Service(value: getUUIDFromBase(pieceUUID: "180D"), isActive: false, humanName: "Heart Rate")
        self.services["UUID_SERVICE_HUMAN_INTERFACE_DEVICE"] = Service(value: getUUIDFromBase(pieceUUID: "1812"), isActive: false, humanName: "Human Interface Device")
        self.services["UUID_SERVICE_IMMEDIATE_ALERT"] = Service(value: getUUIDFromBase(pieceUUID: "1802"), isActive: false, humanName: "Immediate Alert")
        self.services["UUID_SERVICE_INDOOR_POSITIONING"] = Service(value: getUUIDFromBase(pieceUUID: "1821"), isActive: false, humanName: "Indoor Positioning")
        self.services["UUID_SERVICE_INTERNET_PROTOCOL_SUPPORT"] = Service(value: getUUIDFromBase(pieceUUID: "1820"), isActive: false, humanName: "Internet Protocol Support Service")
        self.services["UUID_SERVICE_LINK_LOSS"] = Service(value: getUUIDFromBase(pieceUUID: "1803"), isActive: false, humanName: "Link Loss")
        self.services["UUID_SERVICE_LOCATION_AND_NAVIGATION"] = Service(value: getUUIDFromBase(pieceUUID: "1819"), isActive: false, humanName: "Location and Navigation")
        self.services["UUID_SERVICE_NEXT_DST_CHANGE"] = Service(value: getUUIDFromBase(pieceUUID: "1807"), isActive: false, humanName: "Next DST Change Service")
        self.services["UUID_SERVICE_PHONE_ALERT_STATUS"] = Service(value: getUUIDFromBase(pieceUUID: "180E"), isActive: false, humanName: "Phone Alert Status Service")
        self.services["UUID_SERVICE_PULSE_OXIMETER"] = Service(value: getUUIDFromBase(pieceUUID: "1822"), isActive: false, humanName: "Pulse Oximeter Service")
        self.services["UUID_SERVICE_REFERENCE_TIME_UPDATE"] = Service(value: getUUIDFromBase(pieceUUID: "1806"), isActive: false, humanName: "Reference Time Update Service")
        self.services["UUID_SERVICE_RUNNING_SPEED_AND_CADENCE"] = Service(value: getUUIDFromBase(pieceUUID: "1814"), isActive: false, humanName: "Running Speed and Cadence")
        self.services["UUID_SERVICE_SCAN_PARAMETERS"] = Service(value: getUUIDFromBase(pieceUUID: "1813"), isActive: false, humanName: "Scan Parameters")
        self.services["UUID_SERVICE_TX_POWER"] = Service(value: getUUIDFromBase(pieceUUID: "1804"), isActive: false, humanName: "Tx Power")
        self.services["UUID_SERVICE_USER_DATA"] = Service(value: getUUIDFromBase(pieceUUID: "181C"), isActive: false, humanName: "User Data")
        self.services["UUID_SERVICE_WEIGHT_SCALE"] = Service(value: getUUIDFromBase(pieceUUID: "181D"), isActive: false, humanName: "Weight Scale")
        
        syncWithDB()
    }
    
    public func getCBUUIDs() -> [CBUUID] {
        var result = [CBUUID]()
        for service in self.services {
            result.append(service.value.value)
        }
        return result
    }
    
    public func getHumanNameByValue(val: CBUUID) -> String {
        // We need more value.value.value!! I'm is Grut! Muahaha!
        if let name = self.services.first(where: {$0.value.value == val})?.value.humanName {
            return name
        }
//
//        for service in self.services {
//            if service.value.value == val {
//                return service.value.humanName
//            }
//        }
        return val.uuidString
    }
    
    func getUUIDFromBase(pieceUUID: String) -> CBUUID {
        let fullUUID = BASE_UUID.replacingOccurrences(of: "%s", with: pieceUUID)
        return CBUUID.init(string: fullUUID)
    }
    
    func getXiaomiUUIDFromBase(pieceUUID: String) -> CBUUID {
        let fullUUID = XIAOMI_BASE_UUID.replacingOccurrences(of: "%s", with: pieceUUID)
        return CBUUID.init(string: fullUUID)
    }

    func syncWithDB() {
        Utils.log("AmazfitServices.syncWithDB", args: nil)
        let servicesDB = appDelegate.services

        // very simple check :)
        // DB is empty
        if servicesDB.count == 0 {
            Utils.log("AmazfitServices.simple_check.empty_db", args: nil)
            return
        }
        // very simple check :)
        // list of services not change
        if servicesDB.count == self.services.count {
            Utils.log("AmazfitServices.simple_check.read_from_db", args: nil)
            self.services = servicesDB
            return
        }
        
        // List of services changed, or empty. Store active service
        for service in servicesDB {
            Utils.log("AmazfitServices.sync", args: nil)
            if service.value.isActive != self.services[service.key]!.isActive {
                services[service.key]!.isActive = service.value.isActive
            }
        }
        
        // ...clear DB
        appDelegate.clearServices(callback: servicesClearInDB)
    }
    
    func servicesClearInDB() {
        // ...fill DB, restore active
        Utils.log("AmazfitServices.servicesClearInDB", args: nil)
        appDelegate.addServices(services: self.services)
        self.services = appDelegate.services
    }
    
}


