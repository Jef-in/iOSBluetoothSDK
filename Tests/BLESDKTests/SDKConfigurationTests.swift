//
//  SDKConfigurationTests.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 26/11/25.
//


import Testing
@testable import BLESDK
import CoreBluetooth

@Suite
final class SDKConfigurationTests {
    @Test
    func testDefault() throws {
        let config = SDKConfiguration.default
        #expect(config.serviceUUIDs == nil)
        #expect(config.enableLocationTracking)
        #expect(!config.allowBackgroundScanning)
        #expect(config.rssiThreshold == nil)
    }
    @Test
    func testCustom() throws {
        let uuid = CBUUID(string: "FFE0")
        let config = SDKConfiguration(serviceUUIDs: [uuid], enableLocationTracking: false, allowBackgroundScanning: true, rssiThreshold: -80)
        #expect(config.serviceUUIDs == [uuid])
        #expect(!config.enableLocationTracking)
        #expect(config.allowBackgroundScanning)
        #expect(config.rssiThreshold == -80)
    }
}