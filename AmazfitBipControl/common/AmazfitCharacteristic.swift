//
//  AmazfitCharacteristic.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 18.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//
// Based on the generic BLE specs see https://www.bluetooth.com/specifications/gatt/characteristics

import Foundation
import CoreBluetooth
import UIKit

class AmazfitDefaultCharacteristic: NSObject {
    
    private let BASE_UUID = "0000%s-0000-1000-8000-00805f9b34fb"
    var defaultCharacteristics = [String: DefaultCharacteristic]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var _amazfitCharacteristic: AmazfitDefaultCharacteristic?
    static private var instance : AmazfitDefaultCharacteristic {
        return sharedInstance
    }
    private static let sharedInstance = AmazfitDefaultCharacteristic()
    
    private override init() {
        super.init()
        initAmazfitDefaultCharacteristic()
    }
    
    func initAmazfitDefaultCharacteristic() {
        fillDefaultData()
    }
    
    static func getInstance() -> AmazfitDefaultCharacteristic {
        return instance
    }
    
    
    func fillDefaultData() {
        Utils.log("AmazfitDefaultCharacteristic.init", args: nil)
        
        // Mi
        self.defaultCharacteristics["UUID_CHARACTERISTIC_XIAOMI_HPLUS_CONTROL"] = DefaultCharacteristic(value: CBUUID.init(string: "14702856-620a-3973-7c78-9cfff0876abd"), isActive: false, humanName: "(Propr: HPLUS Control)")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_XIAOMI_HPLUS_MEASUREMENT"] = DefaultCharacteristic(value: CBUUID.init(string: "14702853-620a-3973-7c78-9cfff0876abd"), isActive: false, humanName: "(Propr: HPLUS Measurements)")
        
        // Mi
        self.defaultCharacteristics["UUID_BATT_INFO"] = DefaultCharacteristic(value: CBUUID.init(string: "00000006-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_BATT_INFO")
        self.defaultCharacteristics["UUID_1"] = DefaultCharacteristic(value: CBUUID.init(string: "00000001-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_1")
        self.defaultCharacteristics["UUID_2"] = DefaultCharacteristic(value: CBUUID.init(string: "00000002-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_2")
        self.defaultCharacteristics["UUID_CONFIG"] = DefaultCharacteristic(value: CBUUID.init(string: "00000003-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_CONFIG")
        self.defaultCharacteristics["UUID_4"] = DefaultCharacteristic(value: CBUUID.init(string: "00000004-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_4")
        self.defaultCharacteristics["UUID_5"] = DefaultCharacteristic(value: CBUUID.init(string: "00000005-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_5")
        self.defaultCharacteristics["UUID_STEPS"] = DefaultCharacteristic(value: CBUUID.init(string: "00000007-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_STEPS")
        self.defaultCharacteristics["UUID_8"] = DefaultCharacteristic(value: CBUUID.init(string: "00000008-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_8")
        self.defaultCharacteristics["UUID_9"] = DefaultCharacteristic(value: CBUUID.init(string: "00000010-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_9")
        self.defaultCharacteristics["UUID_10"] = DefaultCharacteristic(value: CBUUID.init(string: "0000000E-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_10")
        self.defaultCharacteristics["UUID_11"] = DefaultCharacteristic(value: CBUUID.init(string: "00000020-0000-3512-2118-0009AF100700"), isActive: false, humanName: "UUID_11")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_WEATHER"] = DefaultCharacteristic(value: CBUUID.init(string: "0000000e-0000-3512-2118-0009af100700"), isActive: false, humanName: "UUID_CHARACTERISTIC_WEATHER")
        
        // Hz
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_DEVICE_INFO"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF01"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_DEVICE_INFO")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_DEVICE_NAME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF02"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_DEVICE_NAME")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_NOTIFICATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF03"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_NOTIFICATION")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_USER_INFO"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF04"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_USER_INFO")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF05"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_CONTROL_POINT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_REALTIME_STEPS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF06"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_REALTIME_STEPS")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_ACTIVITY_DATA"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF07"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_ACTIVITY_DATA")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_FIRMWARE_DATA"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF08"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_FIRMWARE_DATA")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_LE_PARAMS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF09"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_LE_PARAMS")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_DATE_TIME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF0A"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_DATE_TIME")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_STATISTICS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF0B"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_STATISTICS")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_BATTERY"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF0C"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_BATTERY")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_TEST"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF0D"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_TEST")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HZ_SENSOR_DATA"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "FF0E"), isActive: false, humanName: "UUID_CHARACTERISTIC_HZ_SENSOR_DATA")
        
        // Standart
        self.defaultCharacteristics["UUID_CHARACTERISTIC_AEROBIC_HEART_RATE_LOWER_LIMIT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A7E"), isActive: false, humanName: "UUID_CHARACTERISTIC_AEROBIC_HEART_RATE_LOWER_LIMIT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_AEROBIC_HEART_RATE_UPPER_LIMIT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A84"), isActive: false, humanName: "UUID_CHARACTERISTIC_AEROBIC_HEART_RATE_UPPER_LIMIT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_AEROBIC_THRESHOLD"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A7F"), isActive: false, humanName: "UUID_CHARACTERISTIC_AEROBIC_THRESHOLD")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_AGE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A80"), isActive: false, humanName: "UUID_CHARACTERISTIC_AGE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_AGGREGATE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A5A"), isActive: false, humanName: "UUID_CHARACTERISTIC_AGGREGATE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ALERT_CATEGORY_ID"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A43"), isActive: false, humanName: "Alert AlertCategory ID")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ALERT_CATEGORY_ID_BIT_MASK"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A42"), isActive: false, humanName: "Alert AlertCategory ID Bit Mask")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ALERT_LEVEL"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A06"), isActive: false, humanName: "Alert Level")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CLIENT_CHARACTERISTIC_CONFIG"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2902"), isActive: false, humanName: "UUID_CHARACTERISTIC_CLIENT_CHARACTERISTIC_CONFIG")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ALERT_NOTIFICATION_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A44"), isActive: false, humanName: "Alert Notification Control Point")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ALERT_STATUS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A3F"), isActive: false, humanName: "Alert Status")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ALTITUDE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AB3"), isActive: false, humanName: "UUID_CHARACTERISTIC_ALTITUDE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ANAEROBIC_HEART_RATE_LOWER_LIMIT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A81"), isActive: false, humanName: "UUID_CHARACTERISTIC_ANAEROBIC_HEART_RATE_LOWER_LIMIT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ANAEROBIC_HEART_RATE_UPPER_LIMIT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A82"), isActive: false, humanName: "UUID_CHARACTERISTIC_ANAEROBIC_HEART_RATE_UPPER_LIMIT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ANAEROBIC_THRESHOLD"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A83"), isActive: false, humanName: "UUID_CHARACTERISTIC_ANAEROBIC_THRESHOLD")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ANALOG"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A58"), isActive: false, humanName: "UUID_CHARACTERISTIC_ANALOG")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_APPARENT_WIND_DIRECTION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A73"), isActive: false, humanName: "UUID_CHARACTERISTIC_APPARENT_WIND_DIRECTION")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_APPARENT_WIND_SPEED"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A72"), isActive: false, humanName: "UUID_CHARACTERISTIC_APPARENT_WIND_SPEED")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GAP_APPEARANCE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A01"), isActive: false, humanName: "Appearance")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BAROMETRIC_PRESSURE_TREND"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AA3"), isActive: false, humanName: "UUID_CHARACTERISTIC_BAROMETRIC_PRESSURE_TREND")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BATTERY_LEVEL"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A19"), isActive: false, humanName: "Battery Level")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BLOOD_PRESSURE_FEATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A49"), isActive: false, humanName: "Blood Pressure Feature")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BLOOD_PRESSURE_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A35"), isActive: false, humanName: "Blood Pressure Measurement")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BODY_COMPOSITION_FEATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A9B"), isActive: false, humanName: "UUID_CHARACTERISTIC_BODY_COMPOSITION_FEATURE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BODY_COMPOSITION_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A9C"), isActive: false, humanName: "UUID_CHARACTERISTIC_BODY_COMPOSITION_MEASUREMENT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BODY_SENSOR_LOCATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A38"), isActive: false, humanName: "Body Sensor Location")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BOND_MANAGEMENT_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AA4"), isActive: false, humanName: "UUID_CHARACTERISTIC_BOND_MANAGEMENT_CONTROL_POINT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BOND_MANAGEMENT_FEATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AA5"), isActive: false, humanName: "UUID_CHARACTERISTIC_BOND_MANAGEMENT_FEATURE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BOOT_KEYBOARD_INPUT_REPORT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A22"), isActive: false, humanName: "Boot Keyboard Input Report")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BOOT_KEYBOARD_OUTPUT_REPORT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A32"), isActive: false, humanName: "Boot Keyboard Output Report")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_BOOT_MOUSE_INPUT_REPORT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A33"), isActive: false, humanName: "Boot Mouse Input Report")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GAP_CENTRAL_ADDRESS_RESOLUTION_SUPPORT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AA6"), isActive: false, humanName: "UUID_CHARACTERISTIC_GAP_CENTRAL_ADDRESS_RESOLUTION_SUPPORT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CGM_FEATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AA8"), isActive: false, humanName: "UUID_CHARACTERISTIC_CGM_FEATURE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CGM_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AA7"), isActive: false, humanName: "UUID_CHARACTERISTIC_CGM_MEASUREMENT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CGM_SESSION_RUN_TIME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AAB"), isActive: false, humanName: "UUID_CHARACTERISTIC_CGM_SESSION_RUN_TIME")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CGM_SESSION_START_TIME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AAA"), isActive: false, humanName: "UUID_CHARACTERISTIC_CGM_SESSION_START_TIME")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CGM_SPECIFIC_OPS_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AAC"), isActive: false, humanName: "UUID_CHARACTERISTIC_CGM_SPECIFIC_OPS_CONTROL_POINT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CGM_STATUS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AA9"), isActive: false, humanName: "UUID_CHARACTERISTIC_CGM_STATUS")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CSC_FEATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A5C"), isActive: false, humanName: "CSC Feature")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CSC_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A5B"), isActive: false, humanName: "CSC Measurement")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CURRENT_TIME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A2B"), isActive: false, humanName: "Current Time")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CYCLING_POWER_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A66"), isActive: false, humanName: "Cycling Power Control Point")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CYCLING_POWER_FEATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A65"), isActive: false, humanName: "Cycling Power Feature")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CYCLING_POWER_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A63"), isActive: false, humanName: "Cycling Power Measurement")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_CYCLING_POWER_VECTOR"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A64"), isActive: false, humanName: "Cycling Power Vector")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_DATABASE_CHANGE_INCREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A99"), isActive: false, humanName: "UUID_CHARACTERISTIC_DATABASE_CHANGE_INCREMENT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_DATE_OF_BIRTH"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A85"), isActive: false, humanName: "UUID_CHARACTERISTIC_DATE_OF_BIRTH")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_DATE_OF_THRESHOLD_ASSESSMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A86"), isActive: false, humanName: "UUID_CHARACTERISTIC_DATE_OF_THRESHOLD_ASSESSMENT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_DATE_TIME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A08"), isActive: false, humanName: "Date Time")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_DAY_DATE_TIME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A0A"), isActive: false, humanName: "Day Date Time")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_DAY_OF_WEEK"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A09"), isActive: false, humanName: "Day of Week")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_DESCRIPTOR_VALUE_CHANGED"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A7D"), isActive: false, humanName: "UUID_CHARACTERISTIC_DESCRIPTOR_VALUE_CHANGED")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GAP_DEVICE_NAME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A00"), isActive: false, humanName: "Device Name")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_DEW_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A7B"), isActive: false, humanName: "UUID_CHARACTERISTIC_DEW_POINT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_DIGITAL"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A56"), isActive: false, humanName: "UUID_CHARACTERISTIC_DIGITAL")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_DST_OFFSET"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A0D"), isActive: false, humanName: "DST Offset")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_ELEVATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A6C"), isActive: false, humanName: "UUID_CHARACTERISTIC_ELEVATION")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_EMAIL_ADDRESS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A87"), isActive: false, humanName: "UUID_CHARACTERISTIC_EMAIL_ADDRESS")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_EXACT_TIME_256"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A0C"), isActive: false, humanName: "Exact Time 256")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_FAT_BURN_HEART_RATE_LOWER_LIMIT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A88"), isActive: false, humanName: "UUID_CHARACTERISTIC_FAT_BURN_HEART_RATE_LOWER_LIMIT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_FAT_BURN_HEART_RATE_UPPER_LIMIT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A89"), isActive: false, humanName: "UUID_CHARACTERISTIC_FAT_BURN_HEART_RATE_UPPER_LIMIT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_FIRMWARE_REVISION_STRING"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A26"), isActive: false, humanName: "Firmware Revision String")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_FIRST_NAME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A8A"), isActive: false, humanName: "UUID_CHARACTERISTIC_FIRST_NAME")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_FIVE_ZONE_HEART_RATE_LIMITS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A8B"), isActive: false, humanName: "UUID_CHARACTERISTIC_FIVE_ZONE_HEART_RATE_LIMITS")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_FLOOR_NUMBER"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AB2"), isActive: false, humanName: "UUID_CHARACTERISTIC_FLOOR_NUMBER")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GENDER"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A8C"), isActive: false, humanName: "UUID_CHARACTERISTIC_GENDER")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GLUCOSE_FEATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A51"), isActive: false, humanName: "Glucose Feature")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GLUCOSE_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A18"), isActive: false, humanName: "Glucose Measurement")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GLUCOSE_MEASUREMENT_CONTEXT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A34"), isActive: false, humanName: "Glucose Measurement Context")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GUST_FACTOR"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A74"), isActive: false, humanName: "UUID_CHARACTERISTIC_GUST_FACTOR")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HARDWARE_REVISION_STRING"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A27"), isActive: false, humanName: "Hardware Revision String")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HEART_RATE_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A39"), isActive: false, humanName: "Heart Rate Control Point")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HEART_RATE_MAX"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A8D"), isActive: false, humanName: "UUID_CHARACTERISTIC_HEART_RATE_MAX")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HEART_RATE_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A37"), isActive: false, humanName: "Heart Rate Measurement")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HEAT_INDEX"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A7A"), isActive: false, humanName: "UUID_CHARACTERISTIC_HEAT_INDEX")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HEIGHT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A8E"), isActive: false, humanName: "UUID_CHARACTERISTIC_HEIGHT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HID_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A4C"), isActive: false, humanName: "HID Control Point")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HID_INFORMATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A4A"), isActive: false, humanName: "HID Information")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HIP_CIRCUMFERENCE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A8F"), isActive: false, humanName: "UUID_CHARACTERISTIC_HIP_CIRCUMFERENCE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_HUMIDITY"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A6F"), isActive: false, humanName: "UUID_CHARACTERISTIC_HUMIDITY")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_IEEE_11073_20601_REGULATORY_CERTIFICATION_DATA_LIST"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A2A"), isActive: false, humanName: "IEEE 11073-20601 Regulatory Certification Data List")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_INDOOR_POSITIONING_CONFIGURATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AAD"), isActive: false, humanName: "UUID_CHARACTERISTIC_INDOOR_POSITIONING_CONFIGURATION")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_INTERMEDIATE_BLOOD_PRESSURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A36"), isActive: false, humanName: "Intermediate blood Pressure")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_INTERMEDIATE_TEMPERATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A1E"), isActive: false, humanName: "Intermediate Temperature")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_IRRADIANCE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A77"), isActive: false, humanName: "UUID_CHARACTERISTIC_IRRADIANCE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LANGUAGE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AA2"), isActive: false, humanName: "UUID_CHARACTERISTIC_LANGUAGE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LAST_NAME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A90"), isActive: false, humanName: "UUID_CHARACTERISTIC_LAST_NAME")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LATITUDE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AAE"), isActive: false, humanName: "UUID_CHARACTERISTIC_LATITUDE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LN_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A6B"), isActive: false, humanName: "LN Control Point")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LN_FEATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A6A"), isActive: false, humanName: "LN Feature")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LOCAL_EAST_COORDINATE_XML"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AB1"), isActive: false, humanName: "UUID_CHARACTERISTIC_LOCAL_EAST_COORDINATE_XML")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LOCAL_NORTH_COORDINATE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AB0"), isActive: false, humanName: "UUID_CHARACTERISTIC_LOCAL_NORTH_COORDINATE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LOCAL_TIME_INFORMATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A0F"), isActive: false, humanName: "Local Time Information")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LOCATION_AND_SPEED"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A67"), isActive: false, humanName: "Location and Speed")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LOCATION_NAME"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AB5"), isActive: false, humanName: "UUID_CHARACTERISTIC_LOCATION_NAME")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_LONGITUDE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AAF"), isActive: false, humanName: "UUID_CHARACTERISTIC_LONGITUDE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_MAGNETIC_DECLINATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A2C"), isActive: false, humanName: "UUID_CHARACTERISTIC_MAGNETIC_DECLINATION")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_MAGNETIC_FLUX_DENSITY_2D"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AA0"), isActive: false, humanName: "UUID_CHARACTERISTIC_MAGNETIC_FLUX_DENSITY_2D")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_MAGNETIC_FLUX_DENSITY_3D"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AA1"), isActive: false, humanName: "UUID_CHARACTERISTIC_MAGNETIC_FLUX_DENSITY_3D")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_MANUFACTURER_NAME_STRING"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A29"), isActive: false, humanName: "Manufacturer Name String")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_MAXIMUM_RECOMMENDED_HEART_RATE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A91"), isActive: false, humanName: "UUID_CHARACTERISTIC_MAXIMUM_RECOMMENDED_HEART_RATE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_MEASUREMENT_INTERVAL"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A21"), isActive: false, humanName: "Measurement Interval")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_MODEL_NUMBER_STRING"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A24"), isActive: false, humanName: "Model Number String")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_NAVIGATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A68"), isActive: false, humanName: "Navigation")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_NEW_ALERT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A46"), isActive: false, humanName: "New Alert")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GAP_PERIPHERAL_PREFERRED_CONNECTION_PARAMETERS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A04"), isActive: false, humanName: "Peripheral Preferred Connection Parameters")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GAP_PERIPHERAL_PRIVACY_FLAG"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A02"), isActive: false, humanName: "Peripheral Privacy Flag")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_PLX_CONTINUOUS_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A5F"), isActive: false, humanName: "UUID_CHARACTERISTIC_PLX_CONTINUOUS_MEASUREMENT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_PLX_FEATURES"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A60"), isActive: false, humanName: "UUID_CHARACTERISTIC_PLX_FEATURES")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_PLX_SPOT_CHECK_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A5E"), isActive: false, humanName: "UUID_CHARACTERISTIC_PLX_SPOT_CHECK_MEASUREMENT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_PNP_ID"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A50"), isActive: false, humanName: "PnP ID")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_POLLEN_CONCENTRATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A75"), isActive: false, humanName: "UUID_CHARACTERISTIC_POLLEN_CONCENTRATION")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_POSITION_QUALITY"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A69"), isActive: false, humanName: "Position Quality")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_PRESSURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A6D"), isActive: false, humanName: "UUID_CHARACTERISTIC_PRESSURE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_PROTOCOL_MODE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A4E"), isActive: false, humanName: "Protocol Mode")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_RAINFALL"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A78"), isActive: false, humanName: "UUID_CHARACTERISTIC_RAINFALL")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GAP_RECONNECTION_ADDRESS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A03"), isActive: false, humanName: "Reconnection Address")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_RECORD_ACCESS_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A52"), isActive: false, humanName: "Record Access Control Point")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_REFERENCE_TIME_INFORMATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A14"), isActive: false, humanName: "Reference Time Information")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_REPORT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A4D"), isActive: false, humanName: "Report")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_REPORT_MAP"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A4B"), isActive: false, humanName: "Report Map")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_RESTING_HEART_RATE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A92"), isActive: false, humanName: "UUID_CHARACTERISTIC_RESTING_HEART_RATE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_RINGER_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A40"), isActive: false, humanName: "Ringer Control Point")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_RINGER_SETTING"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A41"), isActive: false, humanName: "Ringer Setting")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_RSC_FEATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A54"), isActive: false, humanName: "RSC Feature")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_RSC_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A53"), isActive: false, humanName: "RSC Measurement")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_SC_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A55"), isActive: false, humanName: "SC Control Point")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_SCAN_INTERVAL_WINDOW"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A4F"), isActive: false, humanName: "Scan Interval Window")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_SCAN_REFRESH"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A31"), isActive: false, humanName: "Scan Refresh")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_SENSOR_LOCATION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A5D"), isActive: false, humanName: "Sensor Location")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_SERIAL_NUMBER_STRING"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A25"), isActive: false, humanName: "Serial Number String")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_GATT_SERVICE_CHANGED"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A05"), isActive: false, humanName: "Service Changed")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_SOFTWARE_REVISION_STRING"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A28"), isActive: false, humanName: "Software Revision String")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_SPORT_TYPE_FOR_AEROBIC_AND_ANAEROBIC_THRESHOLDS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A93"), isActive: false, humanName: "UUID_CHARACTERISTIC_SPORT_TYPE_FOR_AEROBIC_AND_ANAEROBIC_THRESHOLDS")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_SUPPORTED_NEW_ALERT_CATEGORY"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A47"), isActive: false, humanName: "Supported New Alert AlertCategory")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_SUPPORTED_UNREAD_ALERT_CATEGORY"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A48"), isActive: false, humanName: "Supported Unread Alert AlertCategory")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_SYSTEM_ID"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A23"), isActive: false, humanName: "System ID")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TEMPERATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A6E"), isActive: false, humanName: "UUID_CHARACTERISTIC_TEMPERATURE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TEMPERATURE_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A1C"), isActive: false, humanName: "Temperature Measurement")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TEMPERATURE_TYPE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A1D"), isActive: false, humanName: "Temperature Type")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_THREE_ZONE_HEART_RATE_LIMITS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A94"), isActive: false, humanName: "UUID_CHARACTERISTIC_THREE_ZONE_HEART_RATE_LIMITS")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TIME_ACCURACY"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A12"), isActive: false, humanName: "Time Accuracy")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TIME_SOURCE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A13"), isActive: false, humanName: "Time Source")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TIME_UPDATE_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A16"), isActive: false, humanName: "Time Update Control Point")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TIME_UPDATE_STATE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A17"), isActive: false, humanName: "Time Update State")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TIME_WITH_DST"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A11"), isActive: false, humanName: "Time with DST")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TIME_ZONE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A0E"), isActive: false, humanName: "Time Zone")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TRUE_WIND_DIRECTION"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A71"), isActive: false, humanName: "UUID_CHARACTERISTIC_TRUE_WIND_DIRECTION")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TRUE_WIND_SPEED"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A70"), isActive: false, humanName: "UUID_CHARACTERISTIC_TRUE_WIND_SPEED")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TWO_ZONE_HEART_RATE_LIMIT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A95"), isActive: false, humanName: "UUID_CHARACTERISTIC_TWO_ZONE_HEART_RATE_LIMIT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_TX_POWER_LEVEL"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A07"), isActive: false, humanName: "Tx Power Level")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_UNCERTAINTY"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2AB4"), isActive: false, humanName: "UUID_CHARACTERISTIC_UNCERTAINTY")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_UNREAD_ALERT_STATUS"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A45"), isActive: false, humanName: "Unread Alert Status")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_USER_CONTROL_POINT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A9F"), isActive: false, humanName: "UUID_CHARACTERISTIC_USER_CONTROL_POINT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_USER_INDEX"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A9A"), isActive: false, humanName: "UUID_CHARACTERISTIC_USER_INDEX")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_UV_INDEX"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A76"), isActive: false, humanName: "UUID_CHARACTERISTIC_UV_INDEX")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_VO2_MAX"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A96"), isActive: false, humanName: "UUID_CHARACTERISTIC_VO2_MAX")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_WAIST_CIRCUMFERENCE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A97"), isActive: false, humanName: "UUID_CHARACTERISTIC_WAIST_CIRCUMFERENCE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_WEIGHT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A98"), isActive: false, humanName: "UUID_CHARACTERISTIC_WEIGHT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_WEIGHT_MEASUREMENT"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A9D"), isActive: false, humanName: "UUID_CHARACTERISTIC_WEIGHT_MEASUREMENT")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_WEIGHT_SCALE_FEATURE"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A9E"), isActive: false, humanName: "UUID_CHARACTERISTIC_WEIGHT_SCALE_FEATURE")
        self.defaultCharacteristics["UUID_CHARACTERISTIC_WIND_CHILL"] = DefaultCharacteristic(value: getUUIDFromBase(pieceUUID: "2A79"), isActive: false, humanName: "UUID_CHARACTERISTIC_WIND_CHILL")
        
        //syncWithDB()
    }
    
    public func getHumanNameByValue(val: CBUUID) -> String {
        // We need more value.value.value!! I'm is Grut! Muahaha!
        if let name = self.defaultCharacteristics.first(where: {$0.value.value == val})?.value.humanName {
            return name
        }
        return val.uuidString
    }
    
    func getUUIDFromBase(pieceUUID: String) -> CBUUID {
        let fullUUID = BASE_UUID.replacingOccurrences(of: "%s", with: pieceUUID)
        return CBUUID.init(string: fullUUID)
    }
    
    func syncWithDB() {
        Utils.log("AmazfitDefaultCharacteristic.syncWithDB", args: nil)
        let defaultCharacteristicsDB = appDelegate.defaultCharacteristics
        
        // very simple check :)
        // DB is empty
        if defaultCharacteristicsDB.count == 0 {
            Utils.log("AmazfitDefaultCharacteristic.simple_check.empty_db", args: nil)
            return
        }
        // very simple check :)
        // list of services not change
        if defaultCharacteristicsDB.count == self.defaultCharacteristics.count {
            Utils.log("AmazfitDefaultCharacteristic.simple_check.read_from_db", args: nil)
            self.defaultCharacteristics = defaultCharacteristicsDB
            return
        }
        
        // List of services changed, or empty. Store active service
        for defaultCharacteristic in defaultCharacteristicsDB {
            Utils.log("AmazfitDefaultCharacteristic.sync", args: nil)
            if defaultCharacteristic.value.isActive != self.defaultCharacteristics[defaultCharacteristic.key]!.isActive {
                self.defaultCharacteristics[defaultCharacteristic.key]!.isActive = defaultCharacteristic.value.isActive
            }
        }
        
        // ...clear DB
        //appDelegate.clearServices(callback: servicesClearInDB)
    }
    
    func defaultCharacteristicsClearInDB() {
        // ...fill DB, restore active
        Utils.log("AmazfitDefaultCharacteristic.servicesClearInDB", args: nil)
        //appDelegate.addServices(services: self.characteristics)
        self.defaultCharacteristics = appDelegate.defaultCharacteristics
    }
    
}
