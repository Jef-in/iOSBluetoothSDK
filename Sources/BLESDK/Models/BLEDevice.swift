//
//  BLEDevice.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 21/11/25.
//


import Foundation
import CoreBluetooth

/// Represents a discovered Bluetooth Low Energy peripheral device.
///
/// `BLEDevice` encapsulates all information about a discovered BLE peripheral, including
/// basic device information (name, RSSI), advertisement data, and optional location information.
public struct BLEDevice: Identifiable, Equatable {
    public let id: UUID
    public let name: String?
    public let rssi: Int
    public let discoveredAt: Date
    public let location: LocationData?
    
    // Raw advertisement data
    public let manufacturerData: Data?
    public let serviceUUIDs: [CBUUID]?
    public let serviceData: [CBUUID: Data]?
    public let txPowerLevel: NSNumber?
    public let isConnectable: Bool?
    
    public init(
        id: UUID,
        name: String?,
        rssi: Int,
        discoveredAt: Date,
        location: LocationData?,
        manufacturerData: Data?,
        serviceUUIDs: [CBUUID]?,
        serviceData: [CBUUID: Data]?,
        txPowerLevel: NSNumber?,
        isConnectable: Bool?
    ) {
        self.id = id
        self.name = name
        self.rssi = rssi
        self.discoveredAt = discoveredAt
        self.location = location
        self.manufacturerData = manufacturerData
        self.serviceUUIDs = serviceUUIDs
        self.serviceData = serviceData
        self.txPowerLevel = txPowerLevel
        self.isConnectable = isConnectable
    }
    
    public static func == (lhs: BLEDevice, rhs: BLEDevice) -> Bool {
        lhs.id == rhs.id
    }
}

extension BLEDevice {
    /// Returns advertised data in a human-readable format
    public var advertisedDataDescription: String {
        var result: [String] = []
        
        if let name = name {
            result.append(Constants.deviceName + name)
        }

        result.append(Constants.rssi + "\(rssi) \(Constants.dbMilliwatts)")

        if let connectable = isConnectable {
            result.append(Constants.connectable + (connectable ? Constants.connectableYes : Constants.connectableNo))
        }

        if let txPower = txPowerLevel {
            result.append(Constants.txPower + "\(txPower) \(Constants.dbMilliwatts)")
        }

        if let services = serviceUUIDs, !services.isEmpty {
            result.append(Constants.services + services.map { $0.uuidString }.joined(separator: ", "))
        }

        if let mfgData = manufacturerData {
            result.append(Constants.manufacturerData + mfgData.hexString)
        }

        if let svcData = serviceData, !svcData.isEmpty {
            for (uuid, data) in svcData {
                result.append(Constants.service + uuid.uuidString + ": " + data.hexString)
            }
        }

        return result.joined(separator: "\n")
    }
}
