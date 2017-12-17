//
//  AmazfitBipService.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 14.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit
import Foundation
import CoreBluetooth

struct AmazfitBipService {
    
    public static var UUID_SERVICE_MIBAND2_SERVICE: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FEE1")
    public static var UUID_SERVICE_HEART_RATE: CBUUID = GattService.getUUIDFromBase(pieceUUID: "180D")
    public static var UUID_SERVICE_FIRMWARE_SERVICE = CBUUID.init(string: "00001530-0000-3512-2118-0009af100700")
    
    public static var UUID_BATT_INFO: CBUUID = CBUUID.init(string: "00000006-0000-3512-2118-0009AF100700")
    public static var UUID_1: CBUUID = CBUUID.init(string: "00000001-0000-3512-2118-0009AF100700")
    public static var UUID_2: CBUUID = CBUUID.init(string: "00000002-0000-3512-2118-0009AF100700")
    public static var UUID_CONFIG: CBUUID = CBUUID.init(string: "00000003-0000-3512-2118-0009AF100700")
    public static var UUID_4: CBUUID = CBUUID.init(string: "00000004-0000-3512-2118-0009AF100700")
    public static var UUID_5: CBUUID = CBUUID.init(string: "00000005-0000-3512-2118-0009AF100700")
    public static var UUID_STEPS: CBUUID = CBUUID.init(string: "00000007-0000-3512-2118-0009AF100700")
    public static var UUID_8: CBUUID = CBUUID.init(string: "00000008-0000-3512-2118-0009AF100700")
    public static var UUID_9: CBUUID = CBUUID.init(string: "00000010-0000-3512-2118-0009AF100700")
    public static var UUID_10: CBUUID = CBUUID.init(string: "0000000E-0000-3512-2118-0009AF100700")
    public static var UUID_11: CBUUID = CBUUID.init(string: "00000020-0000-3512-2118-0009AF100700")
    
    public static func getUUIDS() -> [CBUUID] {
        return [UUID_1, UUID_2, UUID_4,UUID_5,UUID_STEPS,UUID_8,UUID_9,UUID_10,UUID_11]
    }
    
    public static var UUID_CHARACTERISTIC_WEATHER: CBUUID = CBUUID.init(string: "0000000e-0000-3512-2118-0009af100700")
    public static var UUID_CHARACTERISTIC_DEVICE_INFO: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF01")
    public static var UUID_CHARACTERISTIC_DEVICE_NAME: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF02")
    public static var UUID_CHARACTERISTIC_NOTIFICATION: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF03")
    public static var UUID_CHARACTERISTIC_USER_INFO: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF04")
    public static var UUID_CHARACTERISTIC_CONTROL_POINT: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF05")
    public static var UUID_CHARACTERISTIC_REALTIME_STEPS: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF06")
    public static var UUID_CHARACTERISTIC_ACTIVITY_DATA: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF07")
    public static var UUID_CHARACTERISTIC_FIRMWARE_DATA: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF08")
    public static var UUID_CHARACTERISTIC_LE_PARAMS: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF09")
    public static var UUID_CHARACTERISTIC_DATE_TIME: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF0A")
    public static var UUID_CHARACTERISTIC_STATISTICS: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF0B")
    public static var UUID_CHARACTERISTIC_BATTERY: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF0C")
    public static var UUID_CHARACTERISTIC_TEST: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF0D")
    public static var UUID_CHARACTERISTIC_SENSOR_DATA: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF0E")
    public static var UUID_CHARACTERISTIC_PAIR: CBUUID = GattService.getUUIDFromBase(pieceUUID: "FF0F")
    public static var UUID_CHARACTERISTIC_HEART_RATE_CONTROL_POINT: CBUUID = GattCharacteristic.UUID_CHARACTERISTIC_HEART_RATE_CONTROL_POINT
    public static var UUID_CHARACTERISTIC_HEART_RATE_MEASUREMENT: CBUUID = GattCharacteristic.UUID_CHARACTERISTIC_HEART_RATE_MEASUREMENT
    
    // goes to UUID_CHARACTERISTIC_3_CONFIGURATION, TODO: validate this for Mi Band 2, it maybe triggers more than only GPS version...
    public static var COMMAND_REQUEST_GPS_VERSION: [UInt8] = [0x0e];
    
    public static var COMMAND_ACTIVITY_DATA_TYPE_DEBUGLOGS: UInt8 = 0x07;
    
    public static var ENDPOINT_DISPLAY: UInt8 = 0x06;
    
    public static var COMMAND_SET_LANGUAGE_SIMPLIFIED_CHINESE: [UInt8] = [ENDPOINT_DISPLAY, 0x13, 0x00, 0x00];
    public static var COMMAND_SET_LANGUAGE_TRADITIONAL_CHINESE: [UInt8] = [ENDPOINT_DISPLAY, 0x13, 0x00, 0x01];
    public static var COMMAND_SET_LANGUAGE_ENGLISH: [UInt8] = [ENDPOINT_DISPLAY, 0x13, 0x00, 0x02];
    
    
    
}
