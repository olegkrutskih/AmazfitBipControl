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

class AmazfitCharacteristic {
    
    private let BASE_UUID = "0000%s-0000-1000-8000-00805f9b34fb"
    var characteristics = [String: Characteristic]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init() {
        Utils.log("AmazfitCharacteristic.init", args: nil)
        
        self.characteristics["UUID_CHARACTERISTIC_XIAOMI_HPLUS_CONTROL"] = Characteristic(value: CBUUID.init(string: "14702856-620a-3973-7c78-9cfff0876abd"), isActive: false, humanName: "(Propr: HPLUS Control)")
        self.characteristics["UUID_CHARACTERISTIC_XIAOMI_HPLUS_MEASUREMENT"] = Characteristic(value: CBUUID.init(string: "14702853-620a-3973-7c78-9cfff0876abd"), isActive: false, humanName: "(Propr: HPLUS Measurements)")
        
        
        self.characteristics["UUID_CHARACTERISTIC_AEROBIC_HEART_RATE_LOWER_LIMIT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A7E"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_AEROBIC_HEART_RATE_UPPER_LIMIT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A84"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_AEROBIC_THRESHOLD"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A7F"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_AGE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A80"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_AGGREGATE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A5A"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_ALERT_CATEGORY_ID"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A43"), isActive: false, humanName: "Alert AlertCategory ID")
        self.characteristics["UUID_CHARACTERISTIC_ALERT_CATEGORY_ID_BIT_MASK"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A42"), isActive: false, humanName: "Alert AlertCategory ID Bit Mask")
        self.characteristics["UUID_CHARACTERISTIC_ALERT_LEVEL"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A06"), isActive: false, humanName: "Alert Level")
        self.characteristics["UUID_CHARACTERISTIC_CLIENT_CHARACTERISTIC_CONFIG"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2902"), isActive: false, humanName: "")
    
        self.characteristics["UUID_CHARACTERISTIC_ALERT_NOTIFICATION_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A44"), isActive: false, humanName: "Alert Notification Control Point")
        self.characteristics["UUID_CHARACTERISTIC_ALERT_STATUS"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A3F"), isActive: false, humanName: "Alert Status")
        self.characteristics["UUID_CHARACTERISTIC_ALTITUDE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AB3"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_ANAEROBIC_HEART_RATE_LOWER_LIMIT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A81"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_ANAEROBIC_HEART_RATE_UPPER_LIMIT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A82"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_ANAEROBIC_THRESHOLD"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A83"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_ANALOG"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A58"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_APPARENT_WIND_DIRECTION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A73"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_APPARENT_WIND_SPEED"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A72"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_GAP_APPEARANCE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A01"), isActive: false, humanName: "Appearance")
        self.characteristics["UUID_CHARACTERISTIC_BAROMETRIC_PRESSURE_TREND"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AA3"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_BATTERY_LEVEL"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A19"), isActive: false, humanName: "Battery Level")
        self.characteristics["UUID_CHARACTERISTIC_BLOOD_PRESSURE_FEATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A49"), isActive: false, humanName: "Blood Pressure Feature")
        self.characteristics["UUID_CHARACTERISTIC_BLOOD_PRESSURE_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A35"), isActive: false, humanName: "Blood Pressure Measurement")
        self.characteristics["UUID_CHARACTERISTIC_BODY_COMPOSITION_FEATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A9B"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_BODY_COMPOSITION_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A9C"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_BODY_SENSOR_LOCATION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A38"), isActive: false, humanName: "Body Sensor Location")
        self.characteristics["UUID_CHARACTERISTIC_BOND_MANAGEMENT_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AA4"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_BOND_MANAGEMENT_FEATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AA5"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_BOOT_KEYBOARD_INPUT_REPORT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A22"), isActive: false, humanName: "Boot Keyboard Input Report")
        self.characteristics["UUID_CHARACTERISTIC_BOOT_KEYBOARD_OUTPUT_REPORT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A32"), isActive: false, humanName: "Boot Keyboard Output Report")
        self.characteristics["UUID_CHARACTERISTIC_BOOT_MOUSE_INPUT_REPORT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A33"), isActive: false, humanName: "Boot Mouse Input Report")
        self.characteristics["UUID_CHARACTERISTIC_GAP_CENTRAL_ADDRESS_RESOLUTION_SUPPORT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AA6"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_CGM_FEATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AA8"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_CGM_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AA7"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_CGM_SESSION_RUN_TIME"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AAB"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_CGM_SESSION_START_TIME"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AAA"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_CGM_SPECIFIC_OPS_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AAC"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_CGM_STATUS"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AA9"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_CSC_FEATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A5C"), isActive: false, humanName: "CSC Feature")
        self.characteristics["UUID_CHARACTERISTIC_CSC_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A5B"), isActive: false, humanName: "CSC Measurement")
        self.characteristics["UUID_CHARACTERISTIC_CURRENT_TIME"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A2B"), isActive: false, humanName: "Current Time")
        self.characteristics["UUID_CHARACTERISTIC_CYCLING_POWER_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A66"), isActive: false, humanName: "Cycling Power Control Point")
        self.characteristics["UUID_CHARACTERISTIC_CYCLING_POWER_FEATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A65"), isActive: false, humanName: "Cycling Power Feature")
        self.characteristics["UUID_CHARACTERISTIC_CYCLING_POWER_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A63"), isActive: false, humanName: "Cycling Power Measurement")
        self.characteristics["UUID_CHARACTERISTIC_CYCLING_POWER_VECTOR"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A64"), isActive: false, humanName: "Cycling Power Vector")
        self.characteristics["UUID_CHARACTERISTIC_DATABASE_CHANGE_INCREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A99"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_DATE_OF_BIRTH"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A85"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_DATE_OF_THRESHOLD_ASSESSMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A86"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_DATE_TIME"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A08"), isActive: false, humanName: "Date Time")
        self.characteristics["UUID_CHARACTERISTIC_DAY_DATE_TIME"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A0A"), isActive: false, humanName: "Day Date Time")
        self.characteristics["UUID_CHARACTERISTIC_DAY_OF_WEEK"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A09"), isActive: false, humanName: "Day of Week")
        self.characteristics["UUID_CHARACTERISTIC_DESCRIPTOR_VALUE_CHANGED"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A7D"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_GAP_DEVICE_NAME"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A00"), isActive: false, humanName: "Device Name")
        self.characteristics["UUID_CHARACTERISTIC_DEW_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A7B"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_DIGITAL"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A56"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_DST_OFFSET"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A0D"), isActive: false, humanName: "DST Offset")
        self.characteristics["UUID_CHARACTERISTIC_ELEVATION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A6C"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_EMAIL_ADDRESS"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A87"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_EXACT_TIME_256"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A0C"), isActive: false, humanName: "Exact Time 256")
        self.characteristics["UUID_CHARACTERISTIC_FAT_BURN_HEART_RATE_LOWER_LIMIT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A88"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_FAT_BURN_HEART_RATE_UPPER_LIMIT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A89"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_FIRMWARE_REVISION_STRING"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A26"), isActive: false, humanName: "Firmware Revision String")
        self.characteristics["UUID_CHARACTERISTIC_FIRST_NAME"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A8A"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_FIVE_ZONE_HEART_RATE_LIMITS"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A8B"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_FLOOR_NUMBER"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AB2"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_GENDER"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A8C"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_GLUCOSE_FEATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A51"), isActive: false, humanName: "Glucose Feature")
        self.characteristics["UUID_CHARACTERISTIC_GLUCOSE_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A18"), isActive: false, humanName: "Glucose Measurement")
        self.characteristics["UUID_CHARACTERISTIC_GLUCOSE_MEASUREMENT_CONTEXT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A34"), isActive: false, humanName: "Glucose Measurement Context")
        self.characteristics["UUID_CHARACTERISTIC_GUST_FACTOR"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A74"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_HARDWARE_REVISION_STRING"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A27"), isActive: false, humanName: "Hardware Revision String")
        self.characteristics["UUID_CHARACTERISTIC_HEART_RATE_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A39"), isActive: false, humanName: "Heart Rate Control Point")
        self.characteristics["UUID_CHARACTERISTIC_HEART_RATE_MAX"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A8D"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_HEART_RATE_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A37"), isActive: false, humanName: "Heart Rate Measurement")
        self.characteristics["UUID_CHARACTERISTIC_HEAT_INDEX"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A7A"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_HEIGHT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A8E"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_HID_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A4C"), isActive: false, humanName: "HID Control Point")
        self.characteristics["UUID_CHARACTERISTIC_HID_INFORMATION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A4A"), isActive: false, humanName: "HID Information")
        self.characteristics["UUID_CHARACTERISTIC_HIP_CIRCUMFERENCE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A8F"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_HUMIDITY"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A6F"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_IEEE_11073_20601_REGULATORY_CERTIFICATION_DATA_LIST"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A2A"), isActive: false, humanName: "IEEE 11073-20601 Regulatory Certification Data List")
        self.characteristics["UUID_CHARACTERISTIC_INDOOR_POSITIONING_CONFIGURATION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AAD"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_INTERMEDIATE_BLOOD_PRESSURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A36"), isActive: false, humanName: "Intermediate blood Pressure")
        self.characteristics["UUID_CHARACTERISTIC_INTERMEDIATE_TEMPERATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A1E"), isActive: false, humanName: "Intermediate Temperature")
        self.characteristics["UUID_CHARACTERISTIC_IRRADIANCE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A77"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_LANGUAGE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AA2"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_LAST_NAME"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A90"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_LATITUDE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AAE"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_LN_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A6B"), isActive: false, humanName: "LN Control Point")
        self.characteristics["UUID_CHARACTERISTIC_LN_FEATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A6A"), isActive: false, humanName: "LN Feature")
        self.characteristics["UUID_CHARACTERISTIC_LOCAL_EAST_COORDINATE_XML"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AB1"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_LOCAL_NORTH_COORDINATE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AB0"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_LOCAL_TIME_INFORMATION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A0F"), isActive: false, humanName: "Local Time Information")
        self.characteristics["UUID_CHARACTERISTIC_LOCATION_AND_SPEED"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A67"), isActive: false, humanName: "Location and Speed")
        self.characteristics["UUID_CHARACTERISTIC_LOCATION_NAME"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AB5"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_LONGITUDE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AAF"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_MAGNETIC_DECLINATION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A2C"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_MAGNETIC_FLUX_DENSITY_2D"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AA0"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_MAGNETIC_FLUX_DENSITY_3D"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AA1"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_MANUFACTURER_NAME_STRING"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A29"), isActive: false, humanName: "Manufacturer Name String")
        self.characteristics["UUID_CHARACTERISTIC_MAXIMUM_RECOMMENDED_HEART_RATE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A91"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_MEASUREMENT_INTERVAL"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A21"), isActive: false, humanName: "Measurement Interval")
        self.characteristics["UUID_CHARACTERISTIC_MODEL_NUMBER_STRING"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A24"), isActive: false, humanName: "Model Number String")
        self.characteristics["UUID_CHARACTERISTIC_NAVIGATION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A68"), isActive: false, humanName: "Navigation")
        self.characteristics["UUID_CHARACTERISTIC_NEW_ALERT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A46"), isActive: false, humanName: "New Alert")
        self.characteristics["UUID_CHARACTERISTIC_GAP_PERIPHERAL_PREFERRED_CONNECTION_PARAMETERS"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A04"), isActive: false, humanName: "Peripheral Preferred Connection Parameters")
        self.characteristics["UUID_CHARACTERISTIC_GAP_PERIPHERAL_PRIVACY_FLAG"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A02"), isActive: false, humanName: "Peripheral Privacy Flag")
        self.characteristics["UUID_CHARACTERISTIC_PLX_CONTINUOUS_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A5F"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_PLX_FEATURES"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A60"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_PLX_SPOT_CHECK_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A5E"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_PNP_ID"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A50"), isActive: false, humanName: "PnP ID")
        self.characteristics["UUID_CHARACTERISTIC_POLLEN_CONCENTRATION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A75"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_POSITION_QUALITY"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A69"), isActive: false, humanName: "Position Quality")
        self.characteristics["UUID_CHARACTERISTIC_PRESSURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A6D"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_PROTOCOL_MODE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A4E"), isActive: false, humanName: "Protocol Mode")
        self.characteristics["UUID_CHARACTERISTIC_RAINFALL"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A78"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_GAP_RECONNECTION_ADDRESS"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A03"), isActive: false, humanName: "Reconnection Address")
        self.characteristics["UUID_CHARACTERISTIC_RECORD_ACCESS_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A52"), isActive: false, humanName: "Record Access Control Point")
        self.characteristics["UUID_CHARACTERISTIC_REFERENCE_TIME_INFORMATION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A14"), isActive: false, humanName: "Reference Time Information")
        self.characteristics["UUID_CHARACTERISTIC_REPORT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A4D"), isActive: false, humanName: "Report")
        self.characteristics["UUID_CHARACTERISTIC_REPORT_MAP"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A4B"), isActive: false, humanName: "Report Map")
        self.characteristics["UUID_CHARACTERISTIC_RESTING_HEART_RATE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A92"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_RINGER_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A40"), isActive: false, humanName: "Ringer Control Point")
        self.characteristics["UUID_CHARACTERISTIC_RINGER_SETTING"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A41"), isActive: false, humanName: "Ringer Setting")
        self.characteristics["UUID_CHARACTERISTIC_RSC_FEATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A54"), isActive: false, humanName: "RSC Feature")
        self.characteristics["UUID_CHARACTERISTIC_RSC_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A53"), isActive: false, humanName: "RSC Measurement")
        self.characteristics["UUID_CHARACTERISTIC_SC_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A55"), isActive: false, humanName: "SC Control Point")
        self.characteristics["UUID_CHARACTERISTIC_SCAN_INTERVAL_WINDOW"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A4F"), isActive: false, humanName: "Scan Interval Window")
        self.characteristics["UUID_CHARACTERISTIC_SCAN_REFRESH"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A31"), isActive: false, humanName: "Scan Refresh")
        self.characteristics["UUID_CHARACTERISTIC_SENSOR_LOCATION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A5D"), isActive: false, humanName: "Sensor Location")
        self.characteristics["UUID_CHARACTERISTIC_SERIAL_NUMBER_STRING"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A25"), isActive: false, humanName: "Serial Number String")
        self.characteristics["UUID_CHARACTERISTIC_GATT_SERVICE_CHANGED"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A05"), isActive: false, humanName: "Service Changed")
        self.characteristics["UUID_CHARACTERISTIC_SOFTWARE_REVISION_STRING"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A28"), isActive: false, humanName: "Software Revision String")
        self.characteristics["UUID_CHARACTERISTIC_SPORT_TYPE_FOR_AEROBIC_AND_ANAEROBIC_THRESHOLDS"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A93"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_SUPPORTED_NEW_ALERT_CATEGORY"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A47"), isActive: false, humanName: "Supported New Alert AlertCategory")
        self.characteristics["UUID_CHARACTERISTIC_SUPPORTED_UNREAD_ALERT_CATEGORY"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A48"), isActive: false, humanName: "Supported Unread Alert AlertCategory")
        self.characteristics["UUID_CHARACTERISTIC_SYSTEM_ID"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A23"), isActive: false, humanName: "System ID")
        self.characteristics["UUID_CHARACTERISTIC_TEMPERATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A6E"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_TEMPERATURE_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A1C"), isActive: false, humanName: "Temperature Measurement")
        self.characteristics["UUID_CHARACTERISTIC_TEMPERATURE_TYPE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A1D"), isActive: false, humanName: "Temperature Type")
        self.characteristics["UUID_CHARACTERISTIC_THREE_ZONE_HEART_RATE_LIMITS"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A94"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_TIME_ACCURACY"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A12"), isActive: false, humanName: "Time Accuracy")
        self.characteristics["UUID_CHARACTERISTIC_TIME_SOURCE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A13"), isActive: false, humanName: "Time Source")
        self.characteristics["UUID_CHARACTERISTIC_TIME_UPDATE_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A16"), isActive: false, humanName: "Time Update Control Point")
        self.characteristics["UUID_CHARACTERISTIC_TIME_UPDATE_STATE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A17"), isActive: false, humanName: "Time Update State")
        self.characteristics["UUID_CHARACTERISTIC_TIME_WITH_DST"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A11"), isActive: false, humanName: "Time with DST")
        self.characteristics["UUID_CHARACTERISTIC_TIME_ZONE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A0E"), isActive: false, humanName: "Time Zone")
        self.characteristics["UUID_CHARACTERISTIC_TRUE_WIND_DIRECTION"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A71"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_TRUE_WIND_SPEED"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A70"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_TWO_ZONE_HEART_RATE_LIMIT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A95"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_TX_POWER_LEVEL"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A07"), isActive: false, humanName: "Tx Power Level")
        self.characteristics["UUID_CHARACTERISTIC_UNCERTAINTY"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2AB4"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_UNREAD_ALERT_STATUS"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A45"), isActive: false, humanName: "Unread Alert Status")
        self.characteristics["UUID_CHARACTERISTIC_USER_CONTROL_POINT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A9F"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_USER_INDEX"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A9A"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_UV_INDEX"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A76"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_VO2_MAX"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A96"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_WAIST_CIRCUMFERENCE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A97"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_WEIGHT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A98"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_WEIGHT_MEASUREMENT"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A9D"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_WEIGHT_SCALE_FEATURE"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A9E"), isActive: false, humanName: "")
        self.characteristics["UUID_CHARACTERISTIC_WIND_CHILL"] = Characteristic(value: getUUIDFromBase(pieceUUID: "2A79"), isActive: false, humanName: "")
        
        //syncWithDB()
    }
    
    public func getHumanNameByValue(val: CBUUID) -> String {
        // We need more value.value.value!! I'm is Grut! Muahaha!
        if let name = self.characteristics.first(where: {$0.value.value == val})?.value.humanName {
            return name
        }
        
//        for characteristic in self.characteristics {
//            if characteristic.value.value == val {
//                return characteristic.value.humanName
//            }
//        }
        return val.uuidString
    }
    
    func getUUIDFromBase(pieceUUID: String) -> CBUUID {
        let fullUUID = BASE_UUID.replacingOccurrences(of: "%s", with: pieceUUID)
        return CBUUID.init(string: fullUUID)
    }
    
    func syncWithDB() {
        Utils.log("AmazfitCharacteristic.syncWithDB", args: nil)
        let characteristicsDB = appDelegate.characteristics
        
        // very simple check :)
        // DB is empty
        if characteristicsDB.count == 0 {
            Utils.log("AmazfitCharacteristic.simple_check.empty_db", args: nil)
            return
        }
        // very simple check :)
        // list of services not change
        if characteristicsDB.count == self.characteristics.count {
            Utils.log("AmazfitCharacteristic.simple_check.read_from_db", args: nil)
            self.characteristics = characteristicsDB
            return
        }
        
        // List of services changed, or empty. Store active service
        for characteristic in characteristicsDB {
            Utils.log("AmazfitCharacteristic.sync", args: nil)
            if characteristic.value.isActive != self.characteristics[characteristic.key]!.isActive {
                characteristics[characteristic.key]!.isActive = characteristic.value.isActive
            }
        }
        
        // ...clear DB
        //appDelegate.clearServices(callback: servicesClearInDB)
    }
    
    func servicesClearInDB() {
        // ...fill DB, restore active
        Utils.log("AmazfitCharacteristic.servicesClearInDB", args: nil)
        //appDelegate.addServices(services: self.characteristics)
        self.characteristics = appDelegate.characteristics
    }
    
}
