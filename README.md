
# BLE SDK

A lightweight Swift package for scanning and discovering Bluetooth Low Energy (BLE) peripherals on iOS using a modern callback-based architecture.

## Features

- 🔍 **Generic BLE Scanning**: Discover all BLE peripherals or filter by service UUIDs
- 📍 **Location Tagging**: Optionally tag discovered devices with GPS coordinates
- 📱 **iOS 14+ Support**: Built with modern Swift and CoreBluetooth APIs
- 🔋 **Background Scanning**: Optional support for background BLE scanning
- 📊 **Advertisement Data**: Capture manufacturer data, service UUIDs, and service data
- 🎯 **RSSI Filtering**: Filter devices by signal strength
- ⚡ **Callback-Based API**: Simple, modern callback architecture for easy integration
- 🧪 **Unit Tested**: Comprehensive test coverage

## Requirements

- iOS 14.0+
- Swift 5.9+
- Xcode 15.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/Jef-in/iOSBluetoothSDK", from: "1.0.0")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter the repository URL
3. Select version 1.0.0 or later

## Usage

### Basic Setup

```swift
import BLESDK

class MyViewController: UIViewController {
    private var sdkManager: BLESDKManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create SDK manager with default configuration
        sdkManager = BLESDK.createManager()
        
        // Set up callbacks
        setupCallbacks()
    }
    
    private func setupCallbacks() {
        sdkManager.onDeviceDiscovered = { [weak self] device in
            print("New device: \(device.name ?? "Unknown")")
        }
        
        sdkManager.onDeviceUpdated = { [weak self] device in
            print("Updated device: \(device.name ?? "Unknown")")
        }
        
        sdkManager.onScanningStateChanged = { [weak self] state in
            print("Scanning state: \(state)")
        }
        
        sdkManager.onErrorEncountered = { [weak self] error in
            print("Error: \(error.localizedDescription)")
        }
    }
}
```

### Custom Configuration

```swift
let config = SDKConfiguration(
    serviceUUIDs: [CBUUID(string: "FFE0")],  // Filter by specific services
    enableLocationTracking: true,             // Tag with GPS
    allowBackgroundScanning: false,           // Foreground only
    rssiThreshold: -70                        // Minimum signal strength
)

sdkManager = BLESDKManager(configuration: config)
```

### Start/Stop Scanning

```swift
// Start scanning
sdkManager.startScanning()

// Stop scanning
sdkManager.stopScanning()

// Clear discovered devices
sdkManager.clearDevices()
```

### Handle Discovered Devices with Callbacks

```swift
private func setupCallbacks() {
    // Called when a new device is discovered
    sdkManager.onDeviceDiscovered = { [weak self] device in
        print("New device: \(device.name ?? "Unknown")")
        print("RSSI: \(device.rssi)")
        print("Manufacturer Data: \(device.manufacturerData?.hexString ?? "None")")
    }
    
    // Called when an existing device's data is updated
    sdkManager.onDeviceUpdated = { [weak self] device in
        print("Updated device: \(device.name ?? "Unknown")")
    }
    
    // Called when scanning state changes
    sdkManager.onScanningStateChanged = { [weak self] state in
        switch state {
        case .scanning:
            print("Scanning started")
        case .stopped:
            print("Scanning stopped")
        case .paused:
            print("Scanning paused")
        }
    }
    
    // Called when an error occurs
    sdkManager.onErrorEncountered = { [weak self] error in
        print("Error: \(error.localizedDescription)")
    }
}
```

### Access Device Data

```swift
// Get all discovered devices
let devices = sdkManager.devices

// Get specific device
if let device = sdkManager.device(withId: deviceId) {
    // Access device properties
    print("Name: \(device.name ?? "Unknown")")
    print("RSSI: \(device.rssi)")
    print("Services: \(device.serviceUUIDs?.map { $0.uuidString } ?? [])")
    
    // Get human-readable advertisement data
    print(device.advertisedDataDescription)
}
```

## BLEDevice Properties

Each discovered device includes:

- `id`: Unique peripheral identifier (UUID)
- `name`: Advertised device name (optional)
- `rssi`: Signal strength in dBm
- `discoveredAt`: Discovery timestamp
- `location`: GPS coordinates if location tracking enabled
- `manufacturerData`: Manufacturer-specific data
- `serviceUUIDs`: Advertised service UUIDs
- `serviceData`: Service-specific data
- `txPowerLevel`: Transmit power level
- `isConnectable`: Whether device accepts connections

## Configuration Options

### `SDKConfiguration`

- **serviceUUIDs**: Filter scanning to specific service UUIDs (nil = scan all)
- **enableLocationTracking**: Tag devices with GPS coordinates (requires location permissions)
- **allowBackgroundScanning**: Enable background BLE scanning
- **rssiThreshold**: Minimum RSSI value for device filtering (nil = no filtering)

## Required Permissions

Add to your `Info.plist`:

```xml
<!-- Bluetooth permissions -->
<key>NSBluetoothAlwaysUsageDescription</key>
<string>We need Bluetooth to discover nearby devices</string>

<!-- Location permissions (if enableLocationTracking = true) -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to tag discovered devices</string>
```

## Error Handling

The SDK defines these error cases:

- `bluetoothPoweredOff`: Bluetooth is disabled
- `bluetoothUnauthorized`: Bluetooth permission denied
- `bluetoothUnsupported`: Device doesn't support Bluetooth
- `locationServicesDisabled`: Location services disabled
- `locationUnauthorized`: Location permission denied
- `scanningFailed`: BLE scan failed
- `configurationInvalid`: Invalid configuration

## Testing

Run tests using:

```bash
swift test
```

Or in Xcode:
- Press ⌘U to run all tests
- View test coverage in the Coverage tab

## Callback Types

The SDK provides four main callbacks:

- **`onDeviceDiscovered`**: Called when a new BLE device is discovered
  - Type: `(BLEDevice) -> Void`
  
- **`onDeviceUpdated`**: Called when an existing device's advertisement data changes
  - Type: `(BLEDevice) -> Void`
  
- **`onScanningStateChanged`**: Called when the scanning state changes
  - Type: `(ScanningState) -> Void`
  
- **`onErrorEncountered`**: Called when an error occurs
  - Type: `(BLESDKError) -> Void`

## SwiftUI Integration

```swift
import SwiftUI
import BLESDK

class BLEScannerViewModel: ObservableObject {
    @Published var devices: [BLEDevice] = []
    @Published var isScanning: Bool = false
    @Published var errorMessage: String?
    
    private var manager: BLESDKManager?
    
    init() {
        setupManager()
    }
    
    private func setupManager() {
        manager = BLESDK.createManager()
        
        manager?.onDeviceDiscovered = { [weak self] device in
            DispatchQueue.main.async {
                self?.devices.append(device)
            }
        }
        
        manager?.onDeviceUpdated = { [weak self] device in
            DispatchQueue.main.async {
                if let index = self?.devices.firstIndex(where: { $0.id == device.id }) {
                    self?.devices[index] = device
                }
            }
        }
        
        manager?.onScanningStateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.isScanning = (state == .scanning)
            }
        }
        
        manager?.onErrorEncountered = { [weak self] error in
            DispatchQueue.main.async {
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func startScan() {
        devices.removeAll()
        manager?.startScanning()
    }
    
    func stopScan() {
        manager?.stopScanning()
    }
}
```

## Architecture

The SDK uses a callback-based architecture for simplicity and flexibility:

```
BLESDK/
├── BLESDK.swift           # Main entry point with factory method
├── Core/
│   ├── BLESDKManager.swift    # Main SDK manager with callbacks
│   ├── Callbacks.swift        # Callback type definitions
│   └── SDKConfiguration.swift # Configuration options
├── Models/
│   ├── BLEDevice.swift        # Device model with advertisement data
│   ├── LocationData.swift     # GPS location wrapper
│   └── Enums.swift            # ScanningState & BLESDKError
├── Scanner/
│   └── BLEScanner.swift       # CoreBluetooth wrapper
├── Location/
│   └── LocationManager.swift  # CoreLocation wrapper
└── Utilities/
    ├── Constants.swift        # SDK constants
    ├── Extensions.swift       # Helper extensions
    └── Logger.swift           # Logging utility
```

## Demo App

The SDK includes a comprehensive SwiftUI demo app that demonstrates:
- Device discovery and listing
- Real-time RSSI updates
- Advertisement data parsing
- Location tracking on maps
- Scanning state management
- Error handling

Run the demo app to see the SDK in action.

## License

MIT License - See LICENSE file for details

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Support

For issues, questions, or contributions, please open an issue on GitHub.
