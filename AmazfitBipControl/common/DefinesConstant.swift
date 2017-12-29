//
//  DefinesConstant.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 25.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation
import CoreBluetooth

enum DefinesConstant: String {
    case ANCS_SV_UUID = "7905F431-B5CE-4E99-A40F-4B1E122D00D0" // ANCS service
    case ANCS_NS_UUID = "9FBF120D-6301-42D9-8C58-25E699A21DBD" // ANCS Notification Source
    case ANCS_CP_UUID = "69D1D8F3-45E1-49A8-9821-9BBDFDAAD9D9" // ANCS Control Point
    case ANCS_DS_UUID = "22EAC6E9-24D6-4BB5-BE44-B36ACE7C7BFB" // ANCS Data Source
    
    case DEVICE = "FCC882AD-37B1-AB8F-D481-CE430820931B"
    //case DEVICE_NAME = "Amazfit Bip Watch"
    case DEVICE_MODEL = "Watch"
    
    case AMAZFIT_BIP_DEVICE_NAME = "Amazfit Bip Watch"
}
