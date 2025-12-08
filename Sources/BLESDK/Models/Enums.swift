//
//  Enums.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 21/11/25.
//

import Foundation

//// Represents the current scanning state of the BLE SDK.
///
/// The scanning state indicates whether the SDK is actively scanning for BLE devices.
/// Use this to update UI elements that reflect the current scanning status.
public enum ScanningState {
    
    /// Scanning is not active.
    case stopped
    
    /// Actively scanning for BLE devices.
    case scanning
    
    /// Scanning is temporarily paused.
    case paused
}

/// Errors that can occur in the BLE SDK
public enum BLESDKError: Error {
    
    /// Bluetooth is powered off on the device.
    case bluetoothPoweredOff
    
    /// App doesn't have permission to use Bluetooth.
    case bluetoothUnauthorized
    
    /// Bluetooth Low Energy is not supported on this device.
    case bluetoothUnsupported
    
    /// Location services are disabled on the device.
    case locationServicesDisabled
    
    /// App doesn't have permission to access location.
    case locationUnauthorized
    
    /// BLE scanning operation failed.
    case scanningFailed
    
    /// The SDK configuration is invalid.
    case configurationInvalid
}

extension BLESDKError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .bluetoothPoweredOff:
            return Constants.bluetoothPoweredOff
        case .bluetoothUnauthorized:
            return Constants.bluetoothNotAuthorized
        case .bluetoothUnsupported:
            return Constants.bluetoothNotSupported
        case .locationServicesDisabled:
            return Constants.locationServicesDisabled
        case .locationUnauthorized:
            return Constants.locationNotAuthorized
        case .scanningFailed:
            return Constants.bleScanningFailed
        case .configurationInvalid:
            return Constants.sdkConfigInvalid
        }
    }
}
