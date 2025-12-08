//
//  ExtensionsTests.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 26/11/25.
//


import Testing
@testable import BLESDK

import CoreBluetooth

@Suite
final class ExtensionsTests {
    @Test
    func testDataHexString() throws {
        let data = Data([0x01, 0xAB, 0xFF])
        #expect(data.hexString == "01abff")
    }
    @Test
    func testCBUUIDStandardString() throws {
        let uuid = CBUUID(string: "ffe0")
        #expect(uuid.uuidString == "FFE0")
    }
    @Test
    func testDateFormatted() throws {
        let date = Date(timeIntervalSince1970: 0)
        let formatted: String
        if #available(iOS 15.0, macOS 12.0, *) {
            formatted = date.formatted()
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .medium
            formatted = formatter.string(from: date)
        }
        #expect(formatted.contains("1970"))
    }
}
