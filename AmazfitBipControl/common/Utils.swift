//
//  Utils.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 18.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation
import UserNotifications

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
    
    static func letsNotify(message: String, value: Int){
        let content = UNMutableNotificationContent()
        content.badge = 1
        
        content.title = NSString.localizedUserNotificationString(forKey: "ЗБС!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: message, arguments: nil)
        content.categoryIdentifier = "actionCategory"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "zbs", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error:Error?) in
            if error != nil {
                self.log("Error on show notification", args: ["descr": error!])
            }
            
        })
    }
}
