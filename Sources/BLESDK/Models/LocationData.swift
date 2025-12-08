//
//  LocationData.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 21/11/25.
//


import Foundation
import CoreLocation

/// GPS location data associated with a discovered BLE device.
///
/// `LocationData` captures the GPS coordinates where a BLE device was discovered.
/// This information is only available when location tracking is enabled in the
/// SDK configuration and appropriate permissions are granted.
public struct LocationData: Codable, Equatable {
    public let latitude: Double
    public let longitude: Double
    public let altitude: Double?
    public let horizontalAccuracy: Double
    public let verticalAccuracy: Double?
    public let timestamp: Date
    
    public init(
        latitude: Double,
        longitude: Double,
        altitude: Double? = nil,
        horizontalAccuracy: Double,
        verticalAccuracy: Double? = nil,
        timestamp: Date
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.horizontalAccuracy = horizontalAccuracy
        self.verticalAccuracy = verticalAccuracy
        self.timestamp = timestamp
    }
    
    public init(from location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.altitude = location.altitude
        self.horizontalAccuracy = location.horizontalAccuracy
        self.verticalAccuracy = location.verticalAccuracy
        self.timestamp = location.timestamp
    }
}
