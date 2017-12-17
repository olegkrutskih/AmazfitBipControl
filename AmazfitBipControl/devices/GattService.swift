//
//  GattService.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 15.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation
import CoreBluetooth

class GattService {
    
    public static var BASE_UUID = "0000%s-0000-1000-8000-00805f9b34fb"
    
    //part of the generic BLE specs see https://developer.bluetooth.org/gatt/services/Pages/ServicesHome.aspx
    //the list is complete as of 2015-09-28
    public static var UUID_SERVICE_ALERT_NOTIFICATION: CBUUID = getUUIDFromBase(pieceUUID: "1811");
    public static var UUID_SERVICE_AUTOMATION_IO: CBUUID = getUUIDFromBase(pieceUUID: "1815")
    public static var UUID_SERVICE_BATTERY_SERVICE: CBUUID = getUUIDFromBase(pieceUUID: "180F")
    public static var UUID_SERVICE_BLOOD_PRESSURE: CBUUID = getUUIDFromBase(pieceUUID: "1810")
    public static var UUID_SERVICE_BODY_COMPOSITION: CBUUID = getUUIDFromBase(pieceUUID: "181B")
    public static var UUID_SERVICE_BOND_MANAGEMENT: CBUUID = getUUIDFromBase(pieceUUID: "181E")
    public static var UUID_SERVICE_CONTINUOUS_GLUCOSE_MONITORING: CBUUID = getUUIDFromBase(pieceUUID: "181F")
    public static var UUID_SERVICE_CURRENT_TIME: CBUUID = getUUIDFromBase(pieceUUID: "1805")
    public static var UUID_SERVICE_CYCLING_POWER: CBUUID = getUUIDFromBase(pieceUUID: "1818")
    public static var UUID_SERVICE_CYCLING_SPEED_AND_CADENCE: CBUUID = getUUIDFromBase(pieceUUID: "1816")
    public static var UUID_SERVICE_DEVICE_INFORMATION: CBUUID = getUUIDFromBase(pieceUUID: "180A")
    public static var UUID_SERVICE_ENVIRONMENTAL_SENSING: CBUUID = getUUIDFromBase(pieceUUID: "181A")
    public static var UUID_SERVICE_GENERIC_ACCESS: CBUUID = getUUIDFromBase(pieceUUID: "1800")
    public static var UUID_SERVICE_GENERIC_ATTRIBUTE: CBUUID = getUUIDFromBase(pieceUUID: "1801")
    public static var UUID_SERVICE_GLUCOSE: CBUUID = getUUIDFromBase(pieceUUID: "1808")
    public static var UUID_SERVICE_HEALTH_THERMOMETER: CBUUID = getUUIDFromBase(pieceUUID: "1809")
    public static var UUID_SERVICE_HEART_RATE: CBUUID = getUUIDFromBase(pieceUUID: "180D")
    public static var UUID_SERVICE_HUMAN_INTERFACE_DEVICE: CBUUID = getUUIDFromBase(pieceUUID: "1812")
    public static var UUID_SERVICE_IMMEDIATE_ALERT: CBUUID = getUUIDFromBase(pieceUUID: "1802")
    public static var UUID_SERVICE_INDOOR_POSITIONING: CBUUID = getUUIDFromBase(pieceUUID: "1821")
    public static var UUID_SERVICE_INTERNET_PROTOCOL_SUPPORT: CBUUID = getUUIDFromBase(pieceUUID: "1820")
    public static var UUID_SERVICE_LINK_LOSS: CBUUID = getUUIDFromBase(pieceUUID: "1803")
    public static var UUID_SERVICE_LOCATION_AND_NAVIGATION: CBUUID = getUUIDFromBase(pieceUUID: "1819")
    public static var UUID_SERVICE_NEXT_DST_CHANGE: CBUUID = getUUIDFromBase(pieceUUID: "1807")
    public static var UUID_SERVICE_PHONE_ALERT_STATUS: CBUUID = getUUIDFromBase(pieceUUID: "180E")
    public static var UUID_SERVICE_PULSE_OXIMETER: CBUUID = getUUIDFromBase(pieceUUID: "1822")
    public static var UUID_SERVICE_REFERENCE_TIME_UPDATE: CBUUID = getUUIDFromBase(pieceUUID: "1806")
    public static var UUID_SERVICE_RUNNING_SPEED_AND_CADENCE: CBUUID = getUUIDFromBase(pieceUUID: "1814")
    public static var UUID_SERVICE_SCAN_PARAMETERS: CBUUID = getUUIDFromBase(pieceUUID: "1813")
    public static var UUID_SERVICE_TX_POWER: CBUUID = getUUIDFromBase(pieceUUID: "1804")
    public static var UUID_SERVICE_USER_DATA: CBUUID = getUUIDFromBase(pieceUUID: "181C")
    public static var UUID_SERVICE_WEIGHT_SCALE: CBUUID = getUUIDFromBase(pieceUUID: "181D")
    
    static func getGattServices() -> [CBUUID] {
        return [
            UUID_SERVICE_ALERT_NOTIFICATION,
            UUID_SERVICE_AUTOMATION_IO,
            UUID_SERVICE_BATTERY_SERVICE,
            UUID_SERVICE_BLOOD_PRESSURE, UUID_SERVICE_BODY_COMPOSITION, UUID_SERVICE_BOND_MANAGEMENT, UUID_SERVICE_CONTINUOUS_GLUCOSE_MONITORING,
            UUID_SERVICE_CURRENT_TIME,UUID_SERVICE_CYCLING_POWER,UUID_SERVICE_CYCLING_SPEED_AND_CADENCE,UUID_SERVICE_DEVICE_INFORMATION,UUID_SERVICE_ENVIRONMENTAL_SENSING,
            UUID_SERVICE_GENERIC_ACCESS,UUID_SERVICE_GENERIC_ATTRIBUTE,UUID_SERVICE_GLUCOSE,UUID_SERVICE_HEALTH_THERMOMETER,UUID_SERVICE_HEART_RATE,
            UUID_SERVICE_HUMAN_INTERFACE_DEVICE,UUID_SERVICE_IMMEDIATE_ALERT,UUID_SERVICE_INDOOR_POSITIONING,UUID_SERVICE_INDOOR_POSITIONING,UUID_SERVICE_INTERNET_PROTOCOL_SUPPORT,
            UUID_SERVICE_LINK_LOSS,UUID_SERVICE_LOCATION_AND_NAVIGATION,UUID_SERVICE_NEXT_DST_CHANGE,UUID_SERVICE_PHONE_ALERT_STATUS,UUID_SERVICE_PULSE_OXIMETER,
            UUID_SERVICE_REFERENCE_TIME_UPDATE,UUID_SERVICE_RUNNING_SPEED_AND_CADENCE,UUID_SERVICE_SCAN_PARAMETERS,UUID_SERVICE_TX_POWER,
            UUID_SERVICE_USER_DATA,UUID_SERVICE_WEIGHT_SCALE
        ]
    }
    
    //do we need this?
    
//    private static final Map<UUID, String> GATTSERVICE_DEBUG;
//
//    static {
//    GATTSERVICE_DEBUG = new HashMap<>();
//    GATTSERVICE_DEBUG.put(UUID_SERVICE_GENERIC_ACCESS, "Generic Access Service");
//    GATTSERVICE_DEBUG.put(UUID_SERVICE_GENERIC_ATTRIBUTE, "Generic Attribute Service");
//    GATTSERVICE_DEBUG.put(UUID_SERVICE_IMMEDIATE_ALERT, "Immediate Alert");
//
//    }
    
//    public static String lookup(UUID uuid, String fallback) {
//    String name = GATTSERVICE_DEBUG.get(uuid);
//    if (name == null) {
//    name = fallback;
//    }
//    return name;
//    }
    
    static func getUUIDFromBase(pieceUUID: String) -> CBUUID {
        let fullUUID = BASE_UUID.replacingOccurrences(of: "%s", with: pieceUUID)
        return CBUUID.init(string: fullUUID)
    }
}
