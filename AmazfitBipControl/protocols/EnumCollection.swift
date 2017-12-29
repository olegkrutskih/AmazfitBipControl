//
//  EnumCollection.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 29.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var values: [Self] { get }
}

public extension EnumCollection {
    
    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    public static var values: [Self] {
        return Array(self.cases())
    }
}
