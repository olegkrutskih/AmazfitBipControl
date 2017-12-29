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

class AmazfitDefaultServices: NSObject {
    public static let amazfitDeviceName = "Amazfit Bip Watch"
    private let BASE_UUID = "0000%s-0000-1000-8000-00805f9b34fb"
    private let XIAOMI_BASE_UUID = "0000%s-0000-3512-2118-0009af100700"
    var defaultServices = [String: DefaultService]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var _amazfitServices: AmazfitDefaultServices?
    static private var instance : AmazfitDefaultServices {
        return sharedInstance
    }
    private static let sharedInstance = AmazfitDefaultServices()
    
    private override init() {
        super.init()
        initAmazfitDefaultServices()
    }
    
    func initAmazfitDefaultServices() {
        fillDefaultData()
    }
    
    static func getInstance() -> AmazfitDefaultServices {
        return instance
    }


    
    
    func fillDefaultData() {
        Utils.log("AmazfitDefaultServices.init", args: nil)
        
        // Unknown
        self.defaultServices["UUID_SERVICE_MIBAND_SERVICE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "FEE0"), isActive: false, humanName: "UUID_SERVICE_MIBAND_SERVICE")
        self.defaultServices["UUID_SERVICE_MIBAND2_SERVICE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "FEE1"), isActive: false, humanName: "UUID_SERVICE_MIBAND2_SERVICE")
        
        // Proprietary Xiaomi services
        self.defaultServices["UUID_SERVICE_XIAOMI_MILI"] = DefaultService(value: getXiaomiUUIDFromBase(pieceUUID: "FEE0"), isActive: false, humanName: "Xiaomi MiLi Service")
        self.defaultServices["UUID_SERVICE_XIAOMI_FIRMWARE_SERVICE"] = DefaultService(value: getXiaomiUUIDFromBase(pieceUUID: "1530"), isActive: false, humanName: "Xiaomi Firmware Service")
        self.defaultServices["UUID_SERVICE_XIAOMI_HPLUS"] = DefaultService(value: CBUUID.init(string: "14701820-620a-3973-7c78-9cfff0876abd"), isActive: false, humanName: "Xiaomi HPLUS Service")

        // Standart services
        self.defaultServices["UUID_SERVICE_ALERT_NOTIFICATION"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1811"), isActive: false, humanName: "Alert Notification Service")
        self.defaultServices["UUID_SERVICE_AUTOMATION_IO"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1815"), isActive: false, humanName: "Automation IO")
        self.defaultServices["UUID_SERVICE_BATTERY_SERVICE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "180F"), isActive: false, humanName: "Battery Service")
        self.defaultServices["UUID_SERVICE_BLOOD_PRESSURE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1810"), isActive: false, humanName: "Blood Pressure")
        self.defaultServices["UUID_SERVICE_BODY_COMPOSITION"] = DefaultService(value: getUUIDFromBase(pieceUUID: "181B"), isActive: false, humanName: "Body Composition")
        self.defaultServices["UUID_SERVICE_BOND_MANAGEMENT"] = DefaultService(value: getUUIDFromBase(pieceUUID: "181E"), isActive: false, humanName: "Bond Management Service")
        self.defaultServices["UUID_SERVICE_CONTINUOUS_GLUCOSE_MONITORING"] = DefaultService(value: getUUIDFromBase(pieceUUID: "181F"), isActive: false, humanName: "Continuous Glucose Monitoring")
        self.defaultServices["UUID_SERVICE_CURRENT_TIME"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1805"), isActive: false, humanName: "Current Time Service")
        self.defaultServices["UUID_SERVICE_CYCLING_POWER"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1818"), isActive: false, humanName: "Cycling Power")
        self.defaultServices["UUID_SERVICE_CYCLING_SPEED_AND_CADENCE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1816"), isActive: false, humanName: "Cycling Speed and Cadence")
        self.defaultServices["UUID_SERVICE_DEVICE_INFORMATION"] = DefaultService(value: getUUIDFromBase(pieceUUID: "180A"), isActive: false, humanName: "Device Information")
        self.defaultServices["UUID_SERVICE_ENVIRONMENTAL_SENSING"] = DefaultService(value: getUUIDFromBase(pieceUUID: "181A"), isActive: false, humanName: "Environmental Sensing")
        self.defaultServices["UUID_SERVICE_GENERIC_ACCESS"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1800"), isActive: false, humanName: "Generic Access")
        self.defaultServices["UUID_SERVICE_GENERIC_ACCESS"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1801"), isActive: false, humanName: "Generic Attribute")
        self.defaultServices["UUID_SERVICE_GLUCOSE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1808"), isActive: false, humanName: "Glucose")
        self.defaultServices["UUID_SERVICE_HEALTH_THERMOMETER"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1809"), isActive: false, humanName: "Health Thermometer")
        self.defaultServices["UUID_SERVICE_HEART_RATE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "180D"), isActive: false, humanName: "Heart Rate")
        self.defaultServices["UUID_SERVICE_HUMAN_INTERFACE_DEVICE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1812"), isActive: false, humanName: "Human Interface Device")
        self.defaultServices["UUID_SERVICE_IMMEDIATE_ALERT"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1802"), isActive: false, humanName: "Immediate Alert")
        self.defaultServices["UUID_SERVICE_INDOOR_POSITIONING"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1821"), isActive: false, humanName: "Indoor Positioning")
        self.defaultServices["UUID_SERVICE_INTERNET_PROTOCOL_SUPPORT"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1820"), isActive: false, humanName: "Internet Protocol Support Service")
        self.defaultServices["UUID_SERVICE_LINK_LOSS"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1803"), isActive: false, humanName: "Link Loss")
        self.defaultServices["UUID_SERVICE_LOCATION_AND_NAVIGATION"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1819"), isActive: false, humanName: "Location and Navigation")
        self.defaultServices["UUID_SERVICE_NEXT_DST_CHANGE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1807"), isActive: false, humanName: "Next DST Change Service")
        self.defaultServices["UUID_SERVICE_PHONE_ALERT_STATUS"] = DefaultService(value: getUUIDFromBase(pieceUUID: "180E"), isActive: false, humanName: "Phone Alert Status Service")
        self.defaultServices["UUID_SERVICE_PULSE_OXIMETER"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1822"), isActive: false, humanName: "Pulse Oximeter Service")
        self.defaultServices["UUID_SERVICE_REFERENCE_TIME_UPDATE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1806"), isActive: false, humanName: "Reference Time Update Service")
        self.defaultServices["UUID_SERVICE_RUNNING_SPEED_AND_CADENCE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1814"), isActive: false, humanName: "Running Speed and Cadence")
        self.defaultServices["UUID_SERVICE_SCAN_PARAMETERS"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1813"), isActive: false, humanName: "Scan Parameters")
        self.defaultServices["UUID_SERVICE_TX_POWER"] = DefaultService(value: getUUIDFromBase(pieceUUID: "1804"), isActive: false, humanName: "Tx Power")
        self.defaultServices["UUID_SERVICE_USER_DATA"] = DefaultService(value: getUUIDFromBase(pieceUUID: "181C"), isActive: false, humanName: "User Data")
        self.defaultServices["UUID_SERVICE_WEIGHT_SCALE"] = DefaultService(value: getUUIDFromBase(pieceUUID: "181D"), isActive: false, humanName: "Weight Scale")
        
        //syncWithDB()
    }
    
    public func getCBUUIDs() -> [CBUUID] {
        var result = [CBUUID]()
        for defaultService in self.defaultServices {
            result.append(defaultService.value.value)
        }
        Utils.log("AmazfitDefaultServices.getCBUUIDs", args: ["Services": result])
        return result
    }
    
    public func getCBUUID(_ uuidString: String) -> CBUUID {
        return self.defaultServices.first(where: {$0.key == uuidString})!.value.value
    }
    
    public func getHumanNameByValue(val: CBUUID) -> String {
        // We need more value.value.value!! I'm is Grut! Muahaha!
        if let name = self.defaultServices.first(where: {$0.value.value == val})?.value.humanName {
            return name
        }
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
        Utils.log("AmazfitDefaultServices.syncWithDB", args: nil)
        let defaultServicesDB = appDelegate.defaultServices

        // very simple check :)
        // DB is empty
        if defaultServicesDB.count == 0 {
            Utils.log("AmazfitDefaultServices.simple_check.empty_db", args: nil)
            return
        }
        // very simple check :)
        // list of services not change
        if defaultServicesDB.count == self.defaultServices.count {
            Utils.log("AmazfitDefaultServices.simple_check.read_from_db", args: nil)
            self.defaultServices = defaultServicesDB
            return
        }
        
        // List of services changed, or empty. Store active service
        for defaultService in defaultServicesDB {
            Utils.log("AmazfitDefaultServices.sync", args: nil)
            if defaultService.value.isActive != self.defaultServices[defaultService.key]!.isActive {
                defaultServices[defaultService.key]!.isActive = defaultService.value.isActive
            }
        }
        
        // ...clear DB
        appDelegate.clearServices(callback: servicesClearInDB)
    }
    
    func servicesClearInDB() {
        // ...fill DB, restore active
        Utils.log("AmazfitDefaultServices.servicesClearInDB", args: nil)
        appDelegate.addServices(services: self.defaultServices)
        self.defaultServices = appDelegate.defaultServices
    }
    
}


