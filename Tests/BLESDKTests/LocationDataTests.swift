//
//  LocationDataTests.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 26/11/25.
//


import Testing
@testable import BLESDK
import CoreLocation

@Suite
final class LocationDataTests {
    @Test
    func testInit() throws {
        let now = Date()
        let loc = LocationData(latitude: 1.0, longitude: 2.0, altitude: 3.0, horizontalAccuracy: 4.0, verticalAccuracy: 5.0, timestamp: now)
        #expect(loc.latitude == 1.0)
        #expect(loc.longitude == 2.0)
        #expect(loc.altitude == 3.0)
        #expect(loc.horizontalAccuracy == 4.0)
        #expect(loc.verticalAccuracy == 5.0)
        #expect(loc.timestamp == now)
    }
    @Test
    func testFromCLLocation() throws {
        let now = Date()
        let cl = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 20), altitude: 30, horizontalAccuracy: 40, verticalAccuracy: 50, timestamp: now)
        let loc = LocationData(from: cl)
        #expect(loc.latitude == 10)
        #expect(loc.longitude == 20)
        #expect(loc.altitude == 30)
        #expect(loc.horizontalAccuracy == 40)
        #expect(loc.verticalAccuracy == 50)
        #expect(loc.timestamp == now)
    }
}