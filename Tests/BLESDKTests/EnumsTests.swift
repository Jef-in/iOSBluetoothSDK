//
//  EnumsTests.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 26/11/25.
//


import Testing
@testable import BLESDK

@Suite
final class EnumsTests {
    @Test
    func testBLESDKErrorDescriptions() throws {
        #expect(BLESDKError.bluetoothPoweredOff.errorDescription != nil)
        #expect(BLESDKError.bluetoothUnauthorized.errorDescription != nil)
        #expect(BLESDKError.bluetoothUnsupported.errorDescription != nil)
        #expect(BLESDKError.locationServicesDisabled.errorDescription != nil)
        #expect(BLESDKError.locationUnauthorized.errorDescription != nil)
        #expect(BLESDKError.scanningFailed.errorDescription != nil)
        #expect(BLESDKError.configurationInvalid.errorDescription != nil)
    }
    @Test
    func testScanningStateCases() throws {
        let states: [ScanningState] = [.stopped, .scanning, .paused]
        #expect(states.count == 3)
    }
}