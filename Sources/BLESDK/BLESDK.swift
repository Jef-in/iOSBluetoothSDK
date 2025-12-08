// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// Main entry point and convenience interface for the BLE SDK.
public struct BLESDK {
    /// The current version of the BLE SDK.
    public static let version = Constants.sdkVersion
    
    /// Create a new SDK manager instance
    public static func createManager(configuration: SDKConfiguration = .default) -> BLESDKManager {
        return BLESDKManager(configuration: configuration)
    }
}
