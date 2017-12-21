//
//  Utils.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 18.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

class Utils {
    public static var TAG = "<< AmazfitLogger::"
    
    static func log(_ message: String, args: [String: Any]?){
        print(TAG + message + msgBuilder(args: args))
    }
    
    static func log(_ message: String, from: AnyClass, args: [String: Any]?){
        print(TAG + "logged from class: \(from), " + message + msgBuilder(args: args))
    }
    
    static func msgBuilder(args: [String: Any]?) -> String {
        var res = ""
        if args != nil && args!.count > 0 {
            res += ", args: "
            for (key, value) in args! {
                res += "\(key): \(value), "
            }
            res = String(res.dropLast(2))
        }
        res += " >>"
        return res
    }
}
