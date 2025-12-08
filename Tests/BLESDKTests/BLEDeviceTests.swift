//
//  BLEDeviceTests.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 26/11/25.
//


import Testing
@testable import BLESDK

import CoreBluetooth

@Suite
final class BLEDeviceTests {
    @Test
    func testInitAndEquality() throws {
        let id = UUID()
        let device1 = BLEDevice(
            id: id,
            name: "Test",
            rssi: -60,
            discoveredAt: Date(),
            location: nil,
            manufacturerData: nil,
            serviceUUIDs: nil,
            serviceData: nil,
            txPowerLevel: nil,
            isConnectable: true
        )
        let device2 = BLEDevice(
            id: id,
            name: "Other",
            rssi: -70,
            discoveredAt: Date(),
            location: nil,
            manufacturerData: nil,
            serviceUUIDs: nil,
            serviceData: nil,
            txPowerLevel: nil,
            isConnectable: false
        )
        #expect(device1 == device2)
    }
    
    @Test
    func testAdvertisedDataDescription() throws {
        let mfg = Data([0x01, 0x02, 0x03])
        let uuid = CBUUID(string: "FFE0")
        let device = BLEDevice(
            id: UUID(),
            name: "Test",
            rssi: -55,
            discoveredAt: Date(),
            location: nil,
            manufacturerData: mfg,
            serviceUUIDs: [uuid],
            serviceData: [uuid: Data([0x04, 0x05])],
            txPowerLevel: NSNumber(value: 4),
            isConnectable: true
        )
        let desc = device.advertisedDataDescription
        #expect(desc.contains("Test"))
        #expect(desc.contains("FFE0"))
        #expect(desc.contains("010203"))
        #expect(desc.contains("0405"))
    }
}
