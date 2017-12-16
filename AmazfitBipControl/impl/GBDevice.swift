//
//  GBDevice.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 14.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

struct GBDevice: Codable {
    
    enum CodingKeys: String, CodingKey {
        case mName
        case mAddress
        case mVolatileAddress
        case mDeviceType
        case mFirmwareVersion
        case mFirmwareVersion2
        case mModel
        case mState
        case mBatteryLevel
        case mBatteryThresholdPercent
        case mBatteryState
        case mRssi
        case mBusyTask
        case mDeviceInfos
    }
    
    public static let RSSI_UNKNOWN = 0;
    public static let BATTERY_UNKNOWN = -1;
    private static let BATTERY_THRESHOLD_PERCENT = 10;
    public static let EXTRA_DEVICE: String = "device";
    private static let DEVINFO_HW_VER: String = "HW: ";
    private static let DEVINFO_FW_VER: String = "FW: ";
    private static let DEVINFO_HR_VER: String = "HR: ";
    private static let DEVINFO_GPS_VER: String = "GPS: ";
    private static let DEVINFO_ADDR: String = "ADDR: ";
    private static let DEVINFO_ADDR2: String = "ADDR2: ";
    private var mName: String;
    private let mAddress: String;
    private var mVolatileAddress: String;
    private let mDeviceType: DeviceType;
    private var mFirmwareVersion: String = "";
    private var mFirmwareVersion2: String = "";
    private var mModel: String = "";
    private var mState: State = State.NOT_CONNECTED;
    private var mBatteryLevel = BATTERY_UNKNOWN;
    private var mBatteryThresholdPercent = BATTERY_THRESHOLD_PERCENT;
    private var mBatteryState: BatteryState = .UNKNOWN;
    private var mRssi = RSSI_UNKNOWN;
    private var mBusyTask: String = "";
    private var mDeviceInfos: [ItemWithDetails] = [];

    init(address: String, name: String, deviceType: DeviceType) {
        self.init(address: address, address2: "", name: name, deviceType: deviceType)
    }
    
    init(address: String, address2: String, name: String, deviceType: DeviceType) {
        self.mAddress = address;
        self.mName = (name != "") ? name : self.mAddress;
        self.mVolatileAddress = address2;
        self.mDeviceType = deviceType;
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mName, forKey: .mName)
        try container.encode(mAddress, forKey: .mAddress)
        try container.encode(mVolatileAddress, forKey: .mVolatileAddress)
        try container.encode(mDeviceType, forKey: .mDeviceType)
        try container.encode(mFirmwareVersion, forKey: .mFirmwareVersion)
        try container.encode(mFirmwareVersion2, forKey: .mFirmwareVersion2)
        try container.encode(mModel, forKey: .mModel)
        try container.encode(mState, forKey: .mState)
        try container.encode(mBatteryLevel, forKey: .mBatteryLevel)
        try container.encode(mBatteryThresholdPercent, forKey: .mBatteryThresholdPercent)
        try container.encode(mBatteryState, forKey: .mBatteryState)
        try container.encode(mRssi, forKey: .mRssi)
        try container.encode(mBusyTask, forKey: .mBusyTask)
        try container.encode(mDeviceInfos, forKey: .mDeviceInfos)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mName = try container.decode(String.self, forKey: .mName)
        mAddress = try container.decode(String.self, forKey: .mAddress)
        mVolatileAddress = try container.decode(String.self, forKey: .mVolatileAddress)
        mDeviceType = try container.decode(DeviceType.self, forKey: .mDeviceType)
        mFirmwareVersion = try container.decode(String.self, forKey: .mFirmwareVersion)
        mFirmwareVersion2 = try container.decode(String.self, forKey: .mFirmwareVersion2)
        mModel = try container.decode(String.self, forKey: .mModel)
        mState = try container.decode(State.self, forKey: .mState)
        mBatteryLevel = try container.decode(Int.self, forKey: .mBatteryLevel)
        mBatteryThresholdPercent = try container.decode(Int.self, forKey: .mBatteryThresholdPercent)
        mBatteryState = try container.decode(BatteryState.self, forKey: .mBatteryState)
        mRssi = try container.decode(Int.self, forKey: .mRssi)
        mBusyTask = try container.decode(String.self, forKey: .mBusyTask)
        mDeviceInfos = try container.decode(Array.self, forKey: .mDeviceInfos)
    }
    
    func getType() -> DeviceType {
        return mDeviceType
    }
    
}
