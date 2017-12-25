//
//  PeripheralManagerDelegate.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 25.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

@objc protocol PeripheralManagerDelegate: NSObjectProtocol {
    /*
     *  Called when advertising begins (after a call to -startAdvertising)
     */
    @objc optional func didStartAdvertisingWithError(_ server: PeripheralManager, error: Error?)
}
