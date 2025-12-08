//
//  Protocols.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 21/11/25.
//

import Foundation

// MARK: - BLE SDK Callbacks

/// Callback invoked when a new BLE device is discovered for the first time.
///
/// This callback is triggered when the SDK detects a BLE peripheral that hasn't been seen before
/// during the current scanning session.
///
/// - Parameter device: The newly discovered `BLEDevice` object containing device information
public typealias DeviceDiscoveredCallback = (BLEDevice) -> Void

/// Callback invoked when an existing BLE device's information is updated.
///
/// This callback is triggered when the SDK receives new advertisement data from a previously
/// discovered device, such as RSSI changes or updated advertisement packets.
///
/// - Parameter device: The updated `BLEDevice` object with new information
public typealias DeviceUpdatedCallback = (BLEDevice) -> Void

/// Callback invoked when the scanning state changes.
///
/// This callback is triggered whenever the SDK starts or stops scanning for BLE devices.
///
/// - Parameter state: The new `ScanningState` (either `.scanning` or `.stopped`)
public typealias ScanningStateChangedCallback = (ScanningState) -> Void

/// Callback invoked when an error occurs in the SDK.
///
/// This callback is triggered when the SDK encounters errors such as Bluetooth being powered off,
/// authorization issues, or scanning failures.
///
/// - Parameter error: The `BLESDKError` describing what went wrong
public typealias ErrorEncounteredCallback = (BLESDKError) -> Void

// MARK: - BLE Scanner Callbacks

/// Callback invoked when a peripheral is discovered by the scanner.
///
/// This is an internal callback used by `BLEScanner` to notify `BLESDKManager` about
/// discovered peripherals. Typically, you should use `DeviceDiscoveredCallback` instead.
///
/// - Parameter device: The discovered `BLEDevice` object
public typealias PeripheralDiscoveredCallback = (BLEDevice) -> Void

/// Callback invoked when the Bluetooth adapter state changes.
///
/// This callback is triggered when the device's Bluetooth adapter is powered on or off,
/// or when authorization status changes.
///
/// - Parameter isPoweredOn: `true` if Bluetooth is powered on and ready, `false` otherwise
public typealias BluetoothStateChangedCallback = (Bool) -> Void
