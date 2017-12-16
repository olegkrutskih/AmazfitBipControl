//
//  State.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 14.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

public enum State: String, Codable {
    
    // Note: the order is important!
    case NOT_CONNECTED
    case WAITING_FOR_RECONNECT
    case CONNECTING
    case CONNECTED
    case INITIALIZING
    case AUTHENTICATION_REQUIRED // some kind of pairing is required by the device
    case AUTHENTICATING // some kind of pairing is requested by the device
    /**
     * Means that the device is connected AND all the necessary initialization steps
     * have been performed. At the very least, this means that basic information like
     * device name, firmware version, hardware revision (as applicable) is available
     * in the GBDevice.
     */
    case INITIALIZED
    
    
}
