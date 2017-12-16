//
//  DeviceType.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 14.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

struct DeviceType: Codable {
    //TODO: list of devices
    //AMAZFITBIP(12, R.drawable.ic_device_hplus, R.drawable.ic_device_hplus_disabled, R.string.devicetype_amazfit_bip),
    
    private var key: Int;
    private var defaultIcon: Int;
    private var disabledIcon: Int;
    private var name: String;
    
    enum CodingKeys: String, CodingKey {
        case key
        case defaultIcon
        case disabledIcon
        case name
    }
    
    init(key: Int, defaultIcon: Int, disabledIcon: Int, name: String) {
        self.key = key;
        self.defaultIcon = defaultIcon;
        self.disabledIcon = disabledIcon;
        self.name = name;
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(key, forKey: .key)
        try container.encode(defaultIcon, forKey: .defaultIcon)
        try container.encode(disabledIcon, forKey: .disabledIcon)
        try container.encode(name, forKey: .name)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        key = try container.decode(Int.self, forKey: .key)
        defaultIcon = try container.decode(Int.self, forKey: .defaultIcon)
        disabledIcon = try container.decode(Int.self, forKey: .disabledIcon)
        name = try container.decode(String.self, forKey: .name)
    }
    
    init(from key: Int) {
        switch key {
        case 12:
            self.init(key: 12, defaultIcon: -1, disabledIcon: -1, name: "Amazfit Bip");
        default:
            self.init(key: -1, defaultIcon: -1, disabledIcon: -1, name: "Unknown Device");
        }
    }
    
    func getKey() -> Int {
        return key
    }
    
    func isSupported() -> Bool{
        return self.key != -1
    }
    
    static func ==(lhs: DeviceType, rhs: DeviceType) -> Bool {
        return lhs.key == rhs.key
    }
    
//
//    init(withKey: Int) {
//        for type: self.) {
//            if (type.key == key) {
//                return type;
//            }
//        }
//        return DeviceType.UNKNOWN;
//    }
//
//    func getKey() -> Int{
//        return key;
//    }
//    func getDefaultIcon() -> Int{
//        return defaultIcon;
//    }
//    func getDisabledIcon() -> Int{
//        return disabledIcon;
//    }
//    func getName() -> Int{
//        return name;
//    }
    
    
    
}
