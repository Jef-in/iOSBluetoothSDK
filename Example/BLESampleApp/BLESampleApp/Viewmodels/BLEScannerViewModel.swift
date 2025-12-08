//
//  BLEScannerViewModel.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//

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
    
    /// Initializes the BLE SDK manager and sets up callbacks
    private func setupManager() {
        manager = BLESDKManager(configuration: .default)
        setupManagerCallbacks()
    }
    
    /// Configures callbacks for BLE SDK events.
    ///
    /// Sets up handlers for device discovery, updates, state changes, and errors,
    /// ensuring all UI updates happen on the main thread.
    private func setupManagerCallbacks() {
        manager?.onDeviceDiscovered = { [weak self] device in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let index = self.devices.firstIndex(where: { $0.id == device.id }) {
                    self.devices[index] = device
                } else {
                    self.devices.append(device)
                }
            }
        }
        
        manager?.onDeviceUpdated = { [weak self] device in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let index = self.devices.firstIndex(where: { $0.id == device.id }) {
                    self.devices[index] = device
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
    
    /// Starts scanning for BLE devices.
    func startScan() {
        devices.removeAll()
        errorMessage = nil
        isScanning = true
        manager?.startScanning()
    }
    
    /// Stops scanning for BLE devices.
    func stopScan() {
        manager?.stopScanning()
        isScanning = false
    }
}


