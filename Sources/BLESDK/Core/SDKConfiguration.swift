//
//  SDKConfiguration.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 21/11/25.
//


import Foundation
import CoreBluetooth

/// Configuration for the BLE SDK
public struct SDKConfiguration {
    /// Filter to scan only specific service UUIDs (nil for all devices)
    public let serviceUUIDs: [CBUUID]?
    
    /// Whether to enable location tagging for discovered devices
    public let enableLocationTracking: Bool
    
    /// Whether to allow scanning in background
    public let allowBackgroundScanning: Bool
    
    /// Minimum RSSI threshold for discovered devices (nil for no filtering)
    public let rssiThreshold: Int?
    
    public init(
        serviceUUIDs: [CBUUID]? = nil,
        enableLocationTracking: Bool = true,
        allowBackgroundScanning: Bool = false,
        rssiThreshold: Int? = nil
    ) {
        self.serviceUUIDs = serviceUUIDs
        self.enableLocationTracking = enableLocationTracking
        self.allowBackgroundScanning = allowBackgroundScanning
        self.rssiThreshold = rssiThreshold
    }
    
    /// Default configuration
    public static let `default` = SDKConfiguration()
}