import Testing
@testable import BLESDK
import CoreBluetooth
import CoreLocation

@Suite
final class BLESDKTests {
    
    // MARK: - Configuration Tests
    
    @Test
    func testDefaultConfiguration() throws {
        let config = SDKConfiguration.default
        #expect(config.serviceUUIDs == nil)
        #expect(config.enableLocationTracking)
        #expect(!config.allowBackgroundScanning)
        #expect(config.rssiThreshold == nil)
    }
    
    @Test
    func testCustomConfiguration() throws {
        let serviceUUID = CBUUID(string: "FFE0")
        let config = SDKConfiguration(
            serviceUUIDs: [serviceUUID],
            enableLocationTracking: false,
            allowBackgroundScanning: true,
            rssiThreshold: -70
        )
        
        #expect(config.serviceUUIDs?.count == 1)
        #expect(config.serviceUUIDs?.first == serviceUUID)
        #expect(!config.enableLocationTracking)
        #expect(config.allowBackgroundScanning)
        #expect(config.rssiThreshold == -70)
    }
    
    // MARK: - Location Data Tests
    
    @Test
    func testLocationDataInit() throws {
        let location = LocationData(
            latitude: 37.7749,
            longitude: -122.4194,
            altitude: 10.0,
            horizontalAccuracy: 5.0,
            verticalAccuracy: 3.0,
            timestamp: Date()
        )
        
        #expect(location.latitude == 37.7749)
        #expect(location.longitude == -122.4194)
        #expect(location.altitude == 10.0)
        #expect(location.horizontalAccuracy == 5.0)
        #expect(location.verticalAccuracy == 3.0)
    }
    
    @Test
    func testLocationDataFromCLLocation() throws {
        let clLocation = CLLocation(
            coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            altitude: 10.0,
            horizontalAccuracy: 5.0,
            verticalAccuracy: 3.0,
            timestamp: Date()
        )
        
        let location = LocationData(from: clLocation)
        #expect(location.latitude == 37.7749)
        #expect(location.longitude == -122.4194)
        #expect(location.altitude == 10.0)
    }
    
    // MARK: - BLE Device Tests
    
    @Test
    func testBLEDeviceInit() {
        let deviceId = UUID()
        let device = BLEDevice(
            id: deviceId,
            name: "Test Device",
            rssi: -50,
            discoveredAt: Date(),
            location: nil,
            manufacturerData: nil,
            serviceUUIDs: nil,
            serviceData: nil,
            txPowerLevel: nil,
            isConnectable: true
        )
        
        #expect(device.id == deviceId)
        #expect(device.name == "Test Device")
        #expect(device.rssi == -50)
        #expect(device.isConnectable ?? false)
    }
    
    @Test
    func testBLEDeviceEquality() {
        let deviceId = UUID()
        let device1 = BLEDevice(
            id: deviceId,
            name: "Device 1",
            rssi: -50,
            discoveredAt: Date(),
            location: nil,
            manufacturerData: nil,
            serviceUUIDs: nil,
            serviceData: nil,
            txPowerLevel: nil,
            isConnectable: true
        )
        
        let device2 = BLEDevice(
            id: deviceId,
            name: "Device 2",
            rssi: -60,
            discoveredAt: Date(),
            location: nil,
            manufacturerData: nil,
            serviceUUIDs: nil,
            serviceData: nil,
            txPowerLevel: nil,
            isConnectable: false
        )
        
        #expect(device1 == device2) // Same ID = equal
    }
    
    @Test
    func testAdvertisedDataDescription() {
        let serviceUUID = CBUUID(string: "FFE0")
        let mfgData = Data([0x01, 0x02, 0x03, 0x04])
        
        let device = BLEDevice(
            id: UUID(),
            name: "Test Device",
            rssi: -55,
            discoveredAt: Date(),
            location: nil,
            manufacturerData: mfgData,
            serviceUUIDs: [serviceUUID],
            serviceData: nil,
            txPowerLevel: NSNumber(value: 4),
            isConnectable: true
        )
        
        let description = device.advertisedDataDescription
        #expect(description.contains("Test Device"))
        #expect(description.contains("-55"))
        #expect(description.contains("FFE0"))
        #expect(description.contains("01020304"))
        #expect(description.contains("TX Power: 4"))
    }
    
    // MARK: - Extension Tests
    
    @Test
    func testDataHexString() {
        let data = Data([0x01, 0x02, 0xAB, 0xCD])
        #expect(data.hexString == "0102abcd")
    }
    
    @Test
    func testCBUUIDStandardString() {
        let uuid = CBUUID(string: "ffe0")
        #expect(uuid.uuidString == "FFE0")
    }
    
    // MARK: - Error Tests
    
    @Test
    func testBLESDKErrorDescriptions() {
        #expect(BLESDKError.bluetoothPoweredOff.errorDescription != nil)
        #expect(BLESDKError.bluetoothUnauthorized.errorDescription != nil)
        #expect(BLESDKError.bluetoothUnsupported.errorDescription != nil)
        #expect(BLESDKError.locationServicesDisabled.errorDescription != nil)
        #expect(BLESDKError.locationUnauthorized.errorDescription != nil)
        #expect(BLESDKError.scanningFailed.errorDescription != nil)
        #expect(BLESDKError.configurationInvalid.errorDescription != nil)
    }
    
    // MARK: - SDK Manager Tests
    
    @Test
    func testSDKManagerInitialization() {
        let manager = BLESDKManager(configuration: .default)
        #expect(manager.scanningState == .stopped)
        #expect(manager.devices.count == 0)
    }
    
    @Test
    func testSDKVersion() {
        #expect(BLESDK.version == "1.0.0")
    }
    
    @Test
    func testCreateManager() {
        let manager = BLESDK.createManager()
        #expect(manager.scanningState == .stopped)
    }
}
