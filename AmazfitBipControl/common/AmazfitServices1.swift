//
//  AmazfitServices1.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 29.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//
// Based on the generic BLE specs see https://www.bluetooth.com/specifications/gatt/services

import Foundation
import CoreBluetooth
import UIKit

class AmazfitServices1: NSObject {
    public static let amazfitDeviceName = "Amazfit Bip Watch"
    private let BASE_UUID = "0000%s-0000-1000-8000-00805f9b34fb"
    private let XIAOMI_BASE_UUID = "0000%s-0000-3512-2118-0009af100700"
    var defaultServices = [String: DefaultService]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var _amazfitServices: AmazfitServices1?
    static private var instance : AmazfitServices1 {
        return sharedInstance
    }
    private static let sharedInstance = AmazfitServices1()
    
    private override init() {
        super.init()
        initAmazfitServices1()
    }
    
    func initAmazfitServices1() {
        fillDefaultData()
    }
    
    static func getInstance() -> AmazfitServices1 {
        return instance
    }
    
    
    
    
    func fillDefaultData() {
        Utils.log("AmazfitServices1.init", args: nil)
        
        print("\(GattServices.UUID_SERVICE_DEVICE_INFORMATION.name): \(GattServices.UUID_SERVICE_DEVICE_INFORMATION.cbuuid.uuidString), description: \(GattServices.UUID_SERVICE_DEVICE_INFORMATION.description)")
        print("\(GattServices.UUID_SERVICE_XIAOMI_MILI.name): \(GattServices.UUID_SERVICE_XIAOMI_MILI.cbuuid.uuidString), description: \(GattServices.UUID_SERVICE_XIAOMI_MILI.description)")

        
        
        // Unknown
        self.defaultServices["UUID_SERVICE_MIBAND_SERVICE"] = DefaultService(value: CBUUID.init(string: "FEE0"), isActive: false, humanName: "UUID_SERVICE_MIBAND_SERVICE")
        self.defaultServices["UUID_SERVICE_MIBAND2_SERVICE"] = DefaultService(value: CBUUID.init(string: "FEE1"), isActive: false, humanName: "UUID_SERVICE_MIBAND2_SERVICE")
        
        // Proprietary Xiaomi services
        self.defaultServices["UUID_SERVICE_XIAOMI_MILI"] = DefaultService(value: getXiaomiUUIDFromBase(pieceUUID: "FEE0"), isActive: false, humanName: "Xiaomi MiLi Service")
        self.defaultServices["UUID_SERVICE_XIAOMI_FIRMWARE_SERVICE"] = DefaultService(value: getXiaomiUUIDFromBase(pieceUUID: "1530"), isActive: false, humanName: "Xiaomi Firmware Service")
        self.defaultServices["UUID_SERVICE_XIAOMI_HPLUS"] = DefaultService(value: CBUUID.init(string: "14701820-620a-3973-7c78-9cfff0876abd"), isActive: false, humanName: "Xiaomi HPLUS Service")
        
        // Standart services
        self.defaultServices["UUID_SERVICE_ALERT_NOTIFICATION"] = DefaultService(value: CBUUID.init(string: "1811"), isActive: false, humanName: "Alert Notification Service")
        self.defaultServices["UUID_SERVICE_AUTOMATION_IO"] = DefaultService(value: CBUUID.init(string: "1815"), isActive: false, humanName: "Automation IO")
        self.defaultServices["UUID_SERVICE_BATTERY_SERVICE"] = DefaultService(value: CBUUID.init(string: "180F"), isActive: false, humanName: "Battery Service")
        self.defaultServices["UUID_SERVICE_BLOOD_PRESSURE"] = DefaultService(value: CBUUID.init(string: "1810"), isActive: false, humanName: "Blood Pressure")
        self.defaultServices["UUID_SERVICE_BODY_COMPOSITION"] = DefaultService(value: CBUUID.init(string: "181B"), isActive: false, humanName: "Body Composition")
        self.defaultServices["UUID_SERVICE_BOND_MANAGEMENT"] = DefaultService(value: CBUUID.init(string: "181E"), isActive: false, humanName: "Bond Management Service")
        self.defaultServices["UUID_SERVICE_CONTINUOUS_GLUCOSE_MONITORING"] = DefaultService(value: CBUUID.init(string: "181F"), isActive: false, humanName: "Continuous Glucose Monitoring")
        self.defaultServices["UUID_SERVICE_CURRENT_TIME"] = DefaultService(value: CBUUID.init(string: "1805"), isActive: false, humanName: "Current Time Service")
        self.defaultServices["UUID_SERVICE_CYCLING_POWER"] = DefaultService(value: CBUUID.init(string: "1818"), isActive: false, humanName: "Cycling Power")
        self.defaultServices["UUID_SERVICE_CYCLING_SPEED_AND_CADENCE"] = DefaultService(value: CBUUID.init(string: "1816"), isActive: false, humanName: "Cycling Speed and Cadence")
        self.defaultServices["UUID_SERVICE_DEVICE_INFORMATION"] = DefaultService(value: CBUUID.init(string: "180A"), isActive: false, humanName: "Device Information")
        self.defaultServices["UUID_SERVICE_ENVIRONMENTAL_SENSING"] = DefaultService(value: CBUUID.init(string: "181A"), isActive: false, humanName: "Environmental Sensing")
        self.defaultServices["UUID_SERVICE_GENERIC_ACCESS"] = DefaultService(value: CBUUID.init(string: "1800"), isActive: false, humanName: "Generic Access")
        self.defaultServices["UUID_SERVICE_GENERIC_ACCESS"] = DefaultService(value: CBUUID.init(string: "1801"), isActive: false, humanName: "Generic Attribute")
        self.defaultServices["UUID_SERVICE_GLUCOSE"] = DefaultService(value: CBUUID.init(string: "1808"), isActive: false, humanName: "Glucose")
        self.defaultServices["UUID_SERVICE_HEALTH_THERMOMETER"] = DefaultService(value: CBUUID.init(string: "1809"), isActive: false, humanName: "Health Thermometer")
        self.defaultServices["UUID_SERVICE_HEART_RATE"] = DefaultService(value: CBUUID.init(string: "180D"), isActive: false, humanName: "Heart Rate")
        self.defaultServices["UUID_SERVICE_HUMAN_INTERFACE_DEVICE"] = DefaultService(value: CBUUID.init(string: "1812"), isActive: false, humanName: "Human Interface Device")
        self.defaultServices["UUID_SERVICE_IMMEDIATE_ALERT"] = DefaultService(value: CBUUID.init(string: "1802"), isActive: false, humanName: "Immediate Alert")
        self.defaultServices["UUID_SERVICE_INDOOR_POSITIONING"] = DefaultService(value: CBUUID.init(string: "1821"), isActive: false, humanName: "Indoor Positioning")
        self.defaultServices["UUID_SERVICE_INTERNET_PROTOCOL_SUPPORT"] = DefaultService(value: CBUUID.init(string: "1820"), isActive: false, humanName: "Internet Protocol Support Service")
        self.defaultServices["UUID_SERVICE_LINK_LOSS"] = DefaultService(value: CBUUID.init(string: "1803"), isActive: false, humanName: "Link Loss")
        self.defaultServices["UUID_SERVICE_LOCATION_AND_NAVIGATION"] = DefaultService(value: CBUUID.init(string: "1819"), isActive: false, humanName: "Location and Navigation")
        self.defaultServices["UUID_SERVICE_NEXT_DST_CHANGE"] = DefaultService(value: CBUUID.init(string: "1807"), isActive: false, humanName: "Next DST Change Service")
        self.defaultServices["UUID_SERVICE_PHONE_ALERT_STATUS"] = DefaultService(value: CBUUID.init(string: "180E"), isActive: false, humanName: "Phone Alert Status Service")
        self.defaultServices["UUID_SERVICE_PULSE_OXIMETER"] = DefaultService(value: CBUUID.init(string: "1822"), isActive: false, humanName: "Pulse Oximeter Service")
        self.defaultServices["UUID_SERVICE_REFERENCE_TIME_UPDATE"] = DefaultService(value: CBUUID.init(string: "1806"), isActive: false, humanName: "Reference Time Update Service")
        self.defaultServices["UUID_SERVICE_RUNNING_SPEED_AND_CADENCE"] = DefaultService(value: CBUUID.init(string: "1814"), isActive: false, humanName: "Running Speed and Cadence")
        self.defaultServices["UUID_SERVICE_SCAN_PARAMETERS"] = DefaultService(value: CBUUID.init(string: "1813"), isActive: false, humanName: "Scan Parameters")
        self.defaultServices["UUID_SERVICE_TX_POWER"] = DefaultService(value: CBUUID.init(string: "1804"), isActive: false, humanName: "Tx Power")
        self.defaultServices["UUID_SERVICE_USER_DATA"] = DefaultService(value: CBUUID.init(string: "181C"), isActive: false, humanName: "User Data")
        self.defaultServices["UUID_SERVICE_WEIGHT_SCALE"] = DefaultService(value: CBUUID.init(string: "181D"), isActive: false, humanName: "Weight Scale")
        
        //syncWithDB()
    }
    
    public func getCBUUIDs() -> [CBUUID] {
        
        var result = [CBUUID]()
        for defaultService in self.defaultServices {
            result.append(defaultService.value.value)
        }
        Utils.log("AmazfitServices1.getCBUUIDs", args: ["Services": result])
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



