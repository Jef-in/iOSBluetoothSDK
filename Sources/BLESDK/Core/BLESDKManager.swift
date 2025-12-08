//
//  BLESDKManager.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 24/11/25.
//

import Foundation
import CoreBluetooth

/// Main manager for the BLE SDK
public class BLESDKManager: NSObject {
    private let configuration: SDKConfiguration
    private let locationManager: LocationManager?
    private let scanner: BLEScanner
    private let logger: Logger
    
    // Callbacks
    public var onDeviceDiscovered: DeviceDiscoveredCallback?
    public var onDeviceUpdated: DeviceUpdatedCallback?
    public var onScanningStateChanged: ScanningStateChangedCallback?
    public var onErrorEncountered: ErrorEncounteredCallback?
    
    private var discoveredDevices: [UUID: BLEDevice] = [:]
    private var _scanningState: ScanningState = .stopped
    
    public var scanningState: ScanningState {
        get { _scanningState }
        set {
            _scanningState = newValue
            onScanningStateChanged?(newValue)
        }
    }
    
    public var devices: [BLEDevice] {
        Array(discoveredDevices.values).sorted { $0.discoveredAt > $1.discoveredAt }
    }
    
    public init(configuration: SDKConfiguration = .default) {
        self.configuration = configuration
        self.logger = Logger(category: Constants.loggerCategorySDKManager)

        if configuration.enableLocationTracking {
            self.locationManager = LocationManager(enabled: true, logger: Logger(category: Constants.loggerCategoryLocation))
        } else {
            self.locationManager = nil
        }

        self.scanner = BLEScanner(
            configuration: configuration,
            locationManager: locationManager,
            logger: Logger(category: Constants.loggerCategoryScanner)
        )
        
        super.init()
        
        setupScannerCallbacks()
        logger.info(Constants.bleSDKInitialized)
    }
    
    // MARK: - Public Methods
    
    /// Starts scanning for BLE devices.
    ///
    /// This method initiates BLE peripheral scanning based on the configuration provided
    /// during initialization. If location tracking is enabled, it also starts location updates.
    ///
    /// ## Behavior
    /// - Changes `scanningState` to `.scanning`
    /// - Triggers `onScanningStateChanged` callback
    /// - Starts location updates if configured
    /// - Discovered devices trigger `onDeviceDiscovered` callback
    public func startScanning() {
        guard scanningState != .scanning else {
            logger.info(Constants.alreadyScanning)
            return
        }
        
        scanner.startScanning()
        locationManager?.startUpdating()
        scanningState = .scanning
        logger.info(Constants.startedScanning)
    }
    
    /// Stops scanning for BLE devices.
    ///
    /// This method stops the BLE peripheral scanning and location updates (if enabled).
    /// Previously discovered devices remain in the `devices` array until cleared.
    ///
    /// ## Behavior
    /// - Changes `scanningState` to `.stopped`
    /// - Triggers `onScanningStateChanged` callback
    /// - Stops location updates if configured
    /// - Does not clear discovered devices (use `clearDevices()` for that)
    public func stopScanning() {
        guard scanningState == .scanning else {
            logger.info(Constants.notCurrentlyScanning)
            return
        }
        
        scanner.stopScanning()
        locationManager?.stopUpdating()
        scanningState = .stopped
        logger.info(Constants.stoppedScanning)
    }
    
    /// Clears all discovered devices from memory.
    ///
    /// This method removes all devices from the internal cache. The `devices` property
    /// will return an empty array after calling this method.
    public func clearDevices() {
        discoveredDevices.removeAll()
        logger.info(Constants.clearedAllDevices)
    }
    
    /// Retrieves a specific device by its unique identifier.
    ///
    /// - Parameter id: The UUID of the device to retrieve
    /// - Returns: The `BLEDevice` with the matching ID, or `nil` if not found
    public func device(withId id: UUID) -> BLEDevice? {
        discoveredDevices[id]
    }
}


extension BLESDKManager {
    /// Sets up the internal callbacks for scanner events.
    ///
    /// This method configures the scanner's callback handlers to manage device discovery
    /// and Bluetooth state changes. It maintains the internal device cache and triggers
    /// the appropriate public callbacks.
    ///
    private func setupScannerCallbacks() {
        scanner.onPeripheralDiscovered = { [weak self] device in
            guard let self = self else { return }
            
            if self.discoveredDevices[device.id] != nil {
                // Update existing device
                self.discoveredDevices[device.id] = device
                self.onDeviceUpdated?(device)
                self.logger.debug(Constants.updatedDevice + (device.name ?? Constants.unknownDevice))
            } else {
                // New device
                self.discoveredDevices[device.id] = device
                self.onDeviceDiscovered?(device)
                self.logger.debug(Constants.discoveredNewDevice + (device.name ?? Constants.unknownDevice))
            }
        }
        
        scanner.onBluetoothStateChanged = { [weak self] isPoweredOn in
            guard let self = self else { return }
            
            if !isPoweredOn {
                self.scanningState = .stopped
                self.onErrorEncountered?(.bluetoothPoweredOff)
            }
        }
    }
}
