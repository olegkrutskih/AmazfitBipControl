//
//  AmazfitNotifyReaderSupport.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 22.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation
import CoreBluetooth
import MediaPlayer

class AmazfitNotifyReaderSupport {//: NSObject {

//    static private var instance : AmazfitNotifyReaderSupport {
//        return sharedInstance
//    }
//    private static let sharedInstance = AmazfitNotifyReaderSupport()
//
//    private override init() {
//        super.init()
//        initAmazfitNotifyReaderSupport()
//    }
//
//    func initAmazfitNotifyReaderSupport() {
//        //fillDefaultData()
//    }
//
//    static func getInstance() -> AmazfitNotifyReaderSupport {
//        return instance
//    }
    
    static func readStepsValue(data: Data?) -> Int {
        if data != nil {
            var bytes = Array(repeating: 0 as UInt8, count:data!.count/MemoryLayout<UInt8>.size)
            data!.copyBytes(to: &bytes, count:data!.count)
            var steps = Array(repeating: 0 as UInt8, count:2)
            steps.insert(data![1], at: 0)
            steps.insert(data![2], at: 1)
            var value : Int = 0
            let data1 = NSData(bytes: steps, length: 2)
            data1.getBytes(&value, length: 2)
            Utils.log("readStepsValue", args: ["Steps value": value])
            return value
        }
        Utils.log("readStepsValue no data found", args: nil)
        return -1
    }
    
    static func readBatteryLevel(data: Data?) -> Int {
        if data != nil {
            var bytes = Array(repeating: 0 as UInt8, count:data!.count/MemoryLayout<UInt8>.size)
            data!.copyBytes(to: &bytes, count:data!.count)
            var batt = Array(repeating: 0 as UInt8, count:1)
            batt.insert(data![1], at: 0)
            var value : Int = 0
            let data1 = NSData(bytes: batt, length: 2)
            data1.getBytes(&value, length: 1)
            Utils.log("readBatteryLevel", args: ["Battery level": value])
            return value
        }
        Utils.log("readBatteryLevel no data found", args: nil)
        return 0
    }
    
    static func readDeviceEvent(data: Data?) -> AmazfitDeviceEvent {
        if data != nil {
            var bytes = Array(repeating: 0 as UInt8, count:data!.count/MemoryLayout<UInt8>.size)
            data!.copyBytes(to: &bytes, count:data!.count)
            var value : Int = 0
            let data1 = NSData(bytes: bytes, length: 1)
            data1.getBytes(&value, length: 1)
            switch value {
                case AmazfitDeviceEvent.BUTTON_PRESSED.rawValue:
                    Utils.log("readDeviceEvent", args: ["Device event": AmazfitDeviceEvent.BUTTON_PRESSED])
                    playerControl(PlayerActions.PLAY)
                    return AmazfitDeviceEvent.BUTTON_PRESSED
                case AmazfitDeviceEvent.BUTTON_PRESSED_LONG.rawValue:
                    Utils.log("readDeviceEvent", args: ["Device event": AmazfitDeviceEvent.BUTTON_PRESSED_LONG])
                    playerControl(PlayerActions.NEXT)
                    return AmazfitDeviceEvent.BUTTON_PRESSED_LONG
                default:
                    Utils.log("readDeviceEvent unknown event", args: ["Device event": value])
            }
//            if let event = AmazfitDeviceEvent.EVENTS[value] {
//                Utils.log("readDeviceEvent", args: ["Device event": event])
//                if event == "BUTTON_PRESSED" {
//
//                }
//                if event == "BUTTON_PRESSED_LONG" {
//                    playerControl(PlayerActions.NEXT)
//                }
//                return event
//            }
        }
        Utils.log("readDeviceEvent no data found", args: nil)
        return AmazfitDeviceEvent.UNNOWN
    }
    
    static func playerControl(_ action: PlayerActions) {
        let mp = MPMusicPlayerController.systemMusicPlayer
        switch action {
        case PlayerActions.PLAY:
            if mp.playbackState != .playing {
                mp.play()
            } else {
                mp.pause()
            }
        case PlayerActions.NEXT:
            mp.skipToNextItem()
        default:
            mp.pause()
        }
    }

}
