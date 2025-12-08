//
//  Constants.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 21/11/25.
//

import Foundation

/// Centralized constants for BLESDK
public enum Constants {
    // MARK: - BLE Device Strings
    static let deviceName = "Name: "
    static let rssi = "RSSI: "
    static let dbMilliwatts = "dBm"
    static let connectable = "Connectable: "
    static let connectableYes = "Yes"
    static let connectableNo = "No"
    static let txPower = "TX Power: "
    static let services = "Services: "
    static let manufacturerData = "Manufacturer Data: "
    static let service = "Service "
    static let unknownDevice = "Unknown"
    
    // MARK: - Error & Info Messages
    static let bluetoothPoweredOff = "Bluetooth is powered off"
    static let bluetoothNotAuthorized = "Bluetooth access is not authorized"
    static let bluetoothNotSupported = "Bluetooth is not supported on this device"
    static let locationServicesDisabled = "Location services are disabled"
    static let locationNotAuthorized = "Location access is not authorized"
    static let bleScanningFailed = "BLE scanning failed"
    static let sdkConfigInvalid = "SDK configuration is invalid"
    
    static let requestingLocationAuth = "Requesting location authorization"
    static let locationAuthorized = "Location authorized, starting updates"
    static let locationDeniedOrRestricted = "Location access denied or restricted"
    static let unknownLocationAuthStatus = "Unknown location authorization status"
    static let startedLocationUpdates = "Started location updates"
    static let stoppedLocationUpdates = "Stopped location updates"
    static let locationUpdated = "Location updated: "
    static let locationManagerFailed = "Location manager failed: "
    
    static let cannotStartScanning = "Cannot start scanning - Bluetooth not powered on"
    static let startedBLEScanning = "Started BLE scanning"
    static let stoppedBLEScanning = "Stopped BLE scanning"
    static let bluetoothStateChanged = "Bluetooth state changed: "
    static let bluetoothReady = "Bluetooth is ready"
    static let bluetoothNotAvailable = "Bluetooth is not available"
    static let discoveredDevice = "Discovered device: "
    static let bleSDKInitialized = "BLE SDK initialized"
    static let alreadyScanning = "Already scanning"
    static let startedScanning = "Started scanning"
    static let notCurrentlyScanning = "Not currently scanning"
    static let stoppedScanning = "Stopped scanning"
    static let clearedAllDevices = "Cleared all devices"
    static let updatedDevice = "Updated device: "
    static let discoveredNewDevice = "Discovered new device: "
    
    // MARK: - Logger
    static let loggerSubsystem = "com.blesdk"
    static let loggerCategoryBLE = "BLE"
    public static let loggerCategoryLocation = "Location"
    public static let loggerCategoryScanner = "Scanner"
    public static let loggerCategorySDKManager = "SDKManager"
    
    // MARK: - SDK
    static let sdkVersion = "1.0.0"
}
