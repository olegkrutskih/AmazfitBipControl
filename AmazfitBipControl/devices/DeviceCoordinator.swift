//
//  DeviceCoordinator.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 15.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation
import CoreBluetooth

/**
 * This interface is implemented at least once for every supported gadget device.
 * It allows Gadgetbridge to generically deal with different kinds of devices
 * without actually knowing the details of any device.
 * <p/>
 * Instances will be created as needed and asked whether they support a given
 * device. If a coordinator answers true, it will be used to assist in handling
 * the given device.
 */
class DeviceCoordinator {
//    var EXTRA_DEVICE_CANDIDATE: String  { get }
//    {
//        get {
//        return "nodomain.freeyourgadget.gadgetbridge.impl.GBDeviceCandidate.EXTRA_DEVICE_CANDIDATE"
//        }
//    }
    
    var EXTRA_DEVICE_CANDIDATE: String = "nodomain.freeyourgadget.gadgetbridge.impl.GBDeviceCandidate.EXTRA_DEVICE_CANDIDATE"
    
    
    /**
     * Do not attempt to bond after discovery.
     */
    var BONDING_STYLE_NONE: Int = 0
    /**
     * Bond after discovery.
     * This is not recommended, as there are mobile devices on which bonding does not work.
     * Prefer to use #BONDING_STYLE_ASK instead.
     */
    var BONDING_STYLE_BOND: Int = 1;
    /**
     * Let the user decide whether to bond or not after discovery.
     * Prefer this over #BONDING_STYLE_BOND
     */
    var BONDING_STYLE_ASK: Int = 2;
    
    /**
     * Checks whether this coordinator handles the given candidate.
     * Returns the supported device type for the given candidate or
     * DeviceType.UNKNOWN
     *
     * @param candidate
     * @return the supported device type for the given candidate.
     */
    
    func getSupportedType(candidate: GBDeviceCandidate) -> DeviceType? { return nil }
    
    /**
     * Checks whether this coordinator handles the given candidate.
     *
     * @param candidate
     * @return true if this coordinator handles the given candidate.
     */
    func supports(candidate: GBDeviceCandidate) -> Bool { return false }
    
    /**
     * Checks whether this candidate handles the given device.
     *
     * @param device
     * @return true if this coordinator handles the given device.
     */
    func supports(device: GBDevice) -> Bool { return false }
    
    /**
     * Returns a list of scan filters that shall be used to discover devices supported
     * by this coordinator.
     * @return the list of scan filters, may be empty
     */

//    func createBLEScanFilters<T>() -> [T: ScanFilter] {}
    func createBLEScanFilters() -> [ScanFilter]? { return [ScanFilter]() }
    
    func createDevice(candidate: CBPeripheral) -> GBDevice? { return nil }
    
    /**
     * Deletes all information, including all related database content about the
     * given device.
     * @throws GBException
     */
    func deleteDevice(device: GBDevice) throws {} //GBException
    
    /**
     * Returns the kind of device type this coordinator supports.
     *
     * @return
     */
    func getDeviceType() -> DeviceType? { return nil }
    
    /**
     * Returns the Activity class to be started in order to perform a pairing of a
     * given device after its discovery.
     *
     * @return the activity class for pairing/initial authentication, or null if none
     */

    //Class<? extends Activity> getPairingActivity();
    
    /**
     * Returns true if activity data fetching is supported by the device
     * (with this coordinator).
     *
     * @return
     */
    func supportsActivityDataFetching() -> Bool { return false }
    
    /**
     * Returns true if activity tracking is supported by the device
     * (with this coordinator).
     *
     * @return
     */
    func supportsActivityTracking() -> Bool { return false }
    
    /**
     * Returns true if activity data fetching is supported AND possible at this
     * very moment. This will consider the device state (being connected/disconnected/busy...)
     * etc.
     *
     * @param device
     * @return
     */
    func allowFetchActivityData(device: GBDevice) -> Bool { return false }
    
    /**
     * Returns the sample provider for the device being supported.
     *
     * @return
     */
    //SampleProvider<? extends ActivitySample> getSampleProvider(GBDevice device, DaoSession session);
    
    /**
     * Finds an install handler for the given uri that can install the given
     * uri on the device being managed.
     *
     * @param uri
     * @param context
     * @return the install handler or null if that uri cannot be installed on the device
     */
    func findInstallHandler(uri: NSURL) -> InstallHandler? { return nil }
    
    /**
     * Returns true if this device/coordinator supports taking screenshots.
     *
     * @return
     */
    func supportsScreenshots() -> Bool { return false }
    
    /**
     * Returns true if this device/coordinator supports setting alarms.
     *
     * @return
     */
    func supportsAlarmConfiguration() -> Bool { return false }
    
    /**
     * Returns true if this device/coordinator supports alarms with smart wakeup
     * @return
     */
    func supportsSmartWakeup(device: GBDevice) -> Bool { return false }
    
    /**
     * Returns true if the given device supports heart rate measurements.
     * @return
     */
    func supportsHeartRateMeasurement(device: GBDevice) -> Bool { return false }
    
    /**
     * Returns the readable name of the manufacturer.
     */
    func getManufacturer() -> String { return "" }
    
    /**
     * Returns true if this device/coordinator supports managing device apps.
     *
     * @return
     */
    func supportsAppsManagement() -> Bool { return false }
    
    /**
     * Returns the Activity class that will be used to manage device apps.
     *
     * @return
     */
    //Class<? extends Activity> getAppsManagementActivity();
    
    /**
     * Returns how/if the given device should be bonded before connecting to it.
     * @param device
     */
    func getBondingStyle(device: GBDevice) -> Int { return -1 }
    
    /**
     * Indicates whether the device has some kind of calender we can sync to.
     * Also used for generated sunrise/sunset events
     */
    func supportsCalendarEvents() -> Bool { return false }
    
    /**
     * Indicates whether the device supports getting a stream of live data.
     * This can be live HR, steps etc.
     */
    func supportsRealtimeData() -> Bool { return false }
    
    /**
     * Indicates whether the device supports current weather and/or weather
     * forecast display.
     */
    func supportsWeather() -> Bool { return false }
}
