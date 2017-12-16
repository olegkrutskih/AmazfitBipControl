//
//  ItemWithDetails.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 14.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

class ItemWithDetails: PItemWithDetails {
    func getName() -> String {
        //TODO
        return ""
    }
    
    func getDetails() -> String {
        //TODO
        return ""
    }
    
    func getIcon() -> Int {
        //TODO
        return -1
    }
    
    func equals(other: NSObject) -> Bool {
        //
        return false
    }
    
    static func <(lhs: ItemWithDetails, rhs: ItemWithDetails) -> Bool {
        //
        return false
    }
    
    static func ==(lhs: ItemWithDetails, rhs: ItemWithDetails) -> Bool {
        //
        return false
    }
    
    
}

protocol PItemWithDetails: Codable, Comparable {
    func getName() -> String;
    
    func getDetails() -> String;
    
    func getIcon() -> Int;
    
    /**
     * Equality is based on #getName() only.
     *
     * @param other
     */
    func equals(other: NSObject) -> Bool;
}
