//
//  BLEScanner.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 21/11/25.
//


import CoreBluetooth

/// Internal scanner class that interfaces with CoreBluetooth.
///
/// `BLEScanner` wraps the CoreBluetooth `CBCentralManager` and provides a cleaner
/// interface for BLE scanning operations. It handles peripheral discovery, advertisement
/// data parsing, and state management.
public class BLEScanner: NSObject {
    private var centralManager: CBCentralManager!
    private let configuration: SDKConfiguration
    private let locationManager: LocationManager?
    private let logger: Logger
    
    // MARK: - Public Callbacks

    /// Callback invoked when a peripheral is discovered.
    ///
    /// This callback provides discovered `BLEDevice` objects to the caller.
    /// It's invoked for both new devices and updates to existing devices.
    public var onPeripheralDiscovered: PeripheralDiscoveredCallback?
    
    /// Callback invoked when the Bluetooth state changes.
    ///
    /// Use this to monitor when Bluetooth is powered on/off or when
    /// authorization status changes.
    public var onBluetoothStateChanged: BluetoothStateChangedCallback?
    
    private var discoveredPeripherals: [UUID: (peripheral: CBPeripheral, lastSeen: Date)] = [:]
    
    // MARK: - Public Properties
        
    /// Returns whether the scanner is currently scanning for peripherals.
    ///
    /// - Returns: `true` if actively scanning, `false` otherwise
    public var isScanning: Bool {
        centralManager?.isScanning ?? false
    }
    
    public init(
        configuration: SDKConfiguration,
        locationManager: LocationManager?,
        logger: Logger = Logger(category: Constants.loggerCategoryScanner)
    ) {
        self.configuration = configuration
        self.locationManager = locationManager
        self.logger = logger
        
        super.init()
        
        let options: [String: Any] = configuration.allowBackgroundScanning
            ? [CBCentralManagerOptionShowPowerAlertKey: true]
            : [:]
        
        self.centralManager = CBCentralManager(delegate: self, queue: nil, options: options)
    }
    
    // MARK: - Public Methods
        
    /// Starts scanning for BLE peripherals.
    ///
    /// Scanning only starts if Bluetooth is powered on. If Bluetooth is not ready,
    /// an error is logged and the method returns without starting the scan.
    ///
    public func startScanning() {
        guard centralManager.state == .poweredOn else {
            logger.error(Constants.cannotStartScanning)
            return
        }
        
        let options: [String: Any] = [
            CBCentralManagerScanOptionAllowDuplicatesKey: true
        ]
        
        centralManager.scanForPeripherals(
            withServices: configuration.serviceUUIDs,
            options: options
        )
        
        logger.info(Constants.startedBLEScanning)
    }
    
    /// Stops scanning for BLE peripherals.
    ///
    /// This method immediately stops the CoreBluetooth scan operation.
    /// Previously discovered peripherals remain in memory.
    public func stopScanning() {
        centralManager.stopScan()
        logger.info(Constants.stoppedBLEScanning)
    }
    
    /// Creates a `BLEDevice` object from CoreBluetooth discovery data.
    ///
    /// This method parses advertisement data from a discovered peripheral and constructs
    /// a `BLEDevice` object. It applies RSSI filtering and optionally includes location data.
    ///
    /// - Parameters:
    ///   - peripheral: The CoreBluetooth peripheral that was discovered
    ///   - advertisementData: Dictionary containing advertisement packet data
    ///   - rssi: The signal strength indicator value
    ///
    /// - Returns: A configured `BLEDevice` object, or `nil` if the device should be filtered out
    private func createDevice(
        from peripheral: CBPeripheral,
        advertisementData: [String: Any],
        rssi: NSNumber
    ) -> BLEDevice? {
        let rssiValue = rssi.intValue
        
        // Apply RSSI filter if configured
        if let threshold = configuration.rssiThreshold, rssiValue < threshold {
            return nil
        }
        
        let manufacturerData = advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data
        let serviceUUIDs = advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID]
        let serviceData = advertisementData[CBAdvertisementDataServiceDataKey] as? [CBUUID: Data]
        let txPowerLevel = advertisementData[CBAdvertisementDataTxPowerLevelKey] as? NSNumber
        let isConnectable = advertisementData[CBAdvertisementDataIsConnectable] as? Bool
        let localName = advertisementData[CBAdvertisementDataLocalNameKey] as? String
        
        let location: LocationData?
        if configuration.enableLocationTracking, let currentLocation = locationManager?.currentLocation {
            location = LocationData(from: currentLocation)
        } else {
            location = nil
        }
        
        return BLEDevice(
            id: peripheral.identifier,
            name: localName ?? peripheral.name,
            rssi: rssiValue,
            discoveredAt: Date(),
            location: location,
            manufacturerData: manufacturerData,
            serviceUUIDs: serviceUUIDs,
            serviceData: serviceData,
            txPowerLevel: txPowerLevel,
            isConnectable: isConnectable
        )
    }
}

// MARK: - CBCentralManagerDelegate
extension BLEScanner: CBCentralManagerDelegate {
    /// Called when the central manager's state is updated.
    ///
    /// This delegate method monitors Bluetooth adapter state changes and triggers
    /// the `onBluetoothStateChanged` callback to notify the SDK manager.
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        logger.info(Constants.bluetoothStateChanged + "\(central.state.rawValue)")
        
        let isPoweredOn = central.state == .poweredOn
        onBluetoothStateChanged?(isPoweredOn)
        
        if isPoweredOn {
            logger.info(Constants.bluetoothReady)
        } else {
            logger.error(Constants.bluetoothNotAvailable)
        }
    }
    
    /// Called when a peripheral is discovered during scanning.
    ///
    /// This delegate method is invoked each time a peripheral is discovered or updates
    /// its advertisement data. It creates a `BLEDevice` object and notifies the SDK manager.
    public func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String: Any],
        rssi RSSI: NSNumber
    ) {
        guard let device = createDevice(
            from: peripheral,
            advertisementData: advertisementData,
            rssi: RSSI
        ) else {
            return
        }
        
        discoveredPeripherals[peripheral.identifier] = (peripheral, Date())
        
        logger.debug(Constants.discoveredDevice + "\(device.name ?? Constants.unknownDevice) - RSSI: \(device.rssi)")
        onPeripheralDiscovered?(device)
    }
}
