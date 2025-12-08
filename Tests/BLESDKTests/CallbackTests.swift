//
//  CallbackTests.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 04/12/25.
//


import Testing
@testable import BLESDK
import CoreBluetooth
import CoreLocation

@Suite
final class CallbackTests {
    
    // MARK: - BLESDKManager Callback Tests
    
    @Test
    func testOnDeviceDiscoveredCallback() {
        let manager = BLESDKManager(configuration: .default)
        
        manager.onDeviceDiscovered = { device in
            // Callback is invoked with device
        }
        
        #expect(manager.onDeviceDiscovered != nil)
    }
    
    @Test
    func testOnDeviceUpdatedCallback() {
        let manager = BLESDKManager(configuration: .default)
        
        manager.onDeviceUpdated = { device in
            // Callback is invoked with device
        }
        
        #expect(manager.onDeviceUpdated != nil)
    }
    
    @Test
    func testOnScanningStateChangedCallback() {
        let manager = BLESDKManager(configuration: .default)
        
        manager.onScanningStateChanged = { state in
            // Callback is invoked with state
        }
        
        #expect(manager.onScanningStateChanged != nil)
        #expect(manager.scanningState == .stopped)
    }
    
    @Test
    func testOnErrorEncounteredCallback() {
        let manager = BLESDKManager(configuration: .default)
        
        manager.onErrorEncountered = { error in
            // Callback is invoked with error
        }
        
        #expect(manager.onErrorEncountered != nil)
    }
    
    @Test
    func testMultipleCallbacksCanBeSet() {
        let manager = BLESDKManager(configuration: .default)
        
        manager.onDeviceDiscovered = { _ in }
        manager.onDeviceUpdated = { _ in }
        manager.onScanningStateChanged = { _ in }
        manager.onErrorEncountered = { _ in }
        
        #expect(manager.onDeviceDiscovered != nil)
        #expect(manager.onDeviceUpdated != nil)
        #expect(manager.onScanningStateChanged != nil)
        #expect(manager.onErrorEncountered != nil)
    }
    
    @Test
    func testCallbacksCanBeCleared() {
        let manager = BLESDKManager(configuration: .default)
        
        manager.onDeviceDiscovered = { _ in }
        manager.onDeviceUpdated = { _ in }
        manager.onScanningStateChanged = { _ in }
        manager.onErrorEncountered = { _ in }
        
        // Clear all callbacks
        manager.onDeviceDiscovered = nil
        manager.onDeviceUpdated = nil
        manager.onScanningStateChanged = nil
        manager.onErrorEncountered = nil
        
        #expect(manager.onDeviceDiscovered == nil)
        #expect(manager.onDeviceUpdated == nil)
        #expect(manager.onScanningStateChanged == nil)
        #expect(manager.onErrorEncountered == nil)
    }
    
    @Test
    func testScanningStateChangeTriggersCallback() {
        let manager = BLESDKManager(configuration: .default)
        
        var callbackInvoked = false
        var receivedState: ScanningState?
        
        manager.onScanningStateChanged = { state in
            callbackInvoked = true
            receivedState = state
        }
        
        // Manually change scanning state
        manager.scanningState = .scanning
        
        #expect(callbackInvoked)
        #expect(receivedState == .scanning)
    }
    
    // MARK: - BLEScanner Callback Tests
    
    @Test
    func testScannerOnPeripheralDiscoveredCallback() {
        let scanner = BLEScanner(
            configuration: .default,
            locationManager: nil
        )
        
        scanner.onPeripheralDiscovered = { device in
            // Callback is invoked with device
        }
        
        #expect(scanner.onPeripheralDiscovered != nil)
    }
    
    @Test
    func testScannerOnBluetoothStateChangedCallback() {
        let scanner = BLEScanner(
            configuration: .default,
            locationManager: nil
        )
        
        scanner.onBluetoothStateChanged = { isPoweredOn in
            // Callback is invoked with bluetooth state
        }
        
        #expect(scanner.onBluetoothStateChanged != nil)
    }
    
    @Test
    func testScannerCallbacksCanBeCleared() {
        let scanner = BLEScanner(
            configuration: .default,
            locationManager: nil
        )
        
        scanner.onPeripheralDiscovered = { _ in }
        scanner.onBluetoothStateChanged = { _ in }
        
        // Clear callbacks
        scanner.onPeripheralDiscovered = nil
        scanner.onBluetoothStateChanged = nil
        
        #expect(scanner.onPeripheralDiscovered == nil)
        #expect(scanner.onBluetoothStateChanged == nil)
    }
    
}