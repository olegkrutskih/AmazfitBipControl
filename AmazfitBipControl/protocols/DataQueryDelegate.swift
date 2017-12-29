//
//  DataQueryDelegate.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 28.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

@objc protocol DataQueryDelegate: NSObjectProtocol {

    @objc optional func queryBattInfo()
    
}
