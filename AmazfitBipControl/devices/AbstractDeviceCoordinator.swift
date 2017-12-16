////
////  AbstractDeviceCoordinator.swift
////  AmazfitBipControl
////
////  Created by Круцких Олег on 15.12.2017.
////  Copyright © 2017 Круцких Олег. All rights reserved.
////
//
//import Foundation
//import CoreBluetooth
//
//class AbstractDeviceCoordinator: DeviceCoordinator {
//
//    override func supports(candidate: GBDeviceCandidate) -> Bool {
//        return self.getSupportedType(candidate: candidate)!.isSupported()
//    }
//
//    override func supports(device: GBDevice) -> Bool {
//        return self.getDeviceType()!.getKey() == device.getType().getKey()
//    }
//
//    override func createBLEScanFilters() -> [ScanFilter] {
//        return [ScanFilter]()
//    }
//
////    public Collection<? extends ScanFilter> createBLEScanFilters() {
////    return Collections.emptyList();
////    }
//
//    override func createDevice(candidate: CBPeripheral) -> GBDevice {
//        return GBDevice.init(address: candidate.readRSSI(), name: <#T##String#>, deviceType: <#T##DeviceType#>)
//    }
////    public GBDevice createDevice(GBDeviceCandidate candidate) {
////    return new GBDevice(candidate.getDevice().getAddress(), candidate.getName(), getDeviceType());
////    }
//
//    override func deleteDevice(device: GBDevice) throws {
//        //
//    }
////    public void deleteDevice(final GBDevice gbDevice) throws GBException {
////    LOG.info("will try to delete device: " + gbDevice.getName());
////    if (gbDevice.isConnected() || gbDevice.isConnecting()) {
////    GBApplication.deviceService().disconnect();
////    }
////    try (DBHandler dbHandler = GBApplication.acquireDB()) {
////    DaoSession session = dbHandler.getDaoSession();
////    Device device = DBHelper.findDevice(gbDevice, session);
////    if (device != null) {
////    deleteDevice(gbDevice, device, session);
////    QueryBuilder<?> qb = session.getDeviceAttributesDao().queryBuilder();
////    qb.where(DeviceAttributesDao.Properties.DeviceId.eq(device.getId())).buildDelete().executeDeleteWithoutDetachingEntities();
////    session.getDeviceDao().delete(device);
////    } else {
////    LOG.info("device to delete not found in db: " + gbDevice);
////    }
////    } catch (Exception e) {
////    throw new GBException("Error deleting device: " + e.getMessage(), e);
////    }
////    }
//
//
//
//
////    /**
////     * Hook for subclasses to perform device-specific deletion logic, e.g. db cleanup.
////     * @param gbDevice the GBDevice
////     * @param device the corresponding database Device
////     * @param session the session to use
////     * @throws GBException
////     */
////    protected abstract void deleteDevice(@NonNull GBDevice gbDevice, @NonNull Device device, @NonNull DaoSession session) throws GBException;
//
//
//    override func allowFetchActivityData(device: GBDevice) -> Bool {
//        //
//    }
////    @Override
////    public boolean allowFetchActivityData(GBDevice device) {
////    return device.isInitialized() && !device.isBusy() && supportsActivityDataFetching();
////    }
//
//
//    func isHealthWearable(device: CBPeripheral) -> Bool {
//        //
//    }
////    public boolean isHealthWearable(BluetoothDevice device) {
////    BluetoothClass bluetoothClass = device.getBluetoothClass();
////    if (bluetoothClass == null) {
////    LOG.warn("unable to determine bluetooth device class of " + device);
////    return false;
////    }
////    if (bluetoothClass.getMajorDeviceClass() == BluetoothClass.Device.Major.WEARABLE
////    || bluetoothClass.getMajorDeviceClass() == BluetoothClass.Device.Major.UNCATEGORIZED) {
////    int deviceClasses =
////    BluetoothClass.Device.HEALTH_BLOOD_PRESSURE
////    | BluetoothClass.Device.HEALTH_DATA_DISPLAY
////    | BluetoothClass.Device.HEALTH_PULSE_RATE
////    | BluetoothClass.Device.HEALTH_WEIGHING
////    | BluetoothClass.Device.HEALTH_UNCATEGORIZED
////    | BluetoothClass.Device.HEALTH_PULSE_OXIMETER
////    | BluetoothClass.Device.HEALTH_GLUCOSE;
////
////    return (bluetoothClass.getDeviceClass() & deviceClasses) != 0;
////    }
////    return false;
////    }
//
//    override func getBondingStyle(device: GBDevice) -> Int {
//        //
//    }
////    @Override
////    public int getBondingStyle(GBDevice device) {
////    return BONDING_STYLE_ASK;
////    }
//}

