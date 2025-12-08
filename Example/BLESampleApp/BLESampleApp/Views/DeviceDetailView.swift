//
//  DeviceDetailView.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//


import SwiftUI
import BLESDK

/// Detail view for a discovered BLE device.
///
/// Shows device information, advertisement data, and location.
struct DeviceDetailView: View {
    let device: BLEDevice
    @ObservedObject var viewModel: BLEScannerViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showMap = false
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Device Header
                    DeviceHeaderView(device: device)
                    
                    // Tab Selector
                    DeviceTabSelectorView(selectedTab: $selectedTab)
                    
                    // Content based on selected tab
                    if selectedTab == 0 {
                        generalInfoSection
                    } else if selectedTab == 1 {
                        advertisedDataSection
                    } else {
                        locationSection
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(Constants.deviceDetails)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
    
    private var generalInfoSection: some View {
        VStack(spacing: 16) {
            DeviceInfoCardView(icon: "number", title: Constants.uuidLabel, value: device.id.uuidString)
            
            if let name = device.name {
                DeviceInfoCardView(icon: "textformat", title: Constants.nameLabel, value: name)
            }
            
            DeviceInfoCardView(icon: "antenna.radiowaves.left.and.right", title: Constants.rssiLabel, value: "\(device.rssi) " + Constants.rssiSuffix)
            
            DeviceInfoCardView(icon: "clock", title: Constants.discoveredLabel, value: DateUtils.formatDate(device.discoveredAt))
            
            if let connectable = device.isConnectable {
                DeviceInfoCardView(icon: "link", title: Constants.connectableLabel, value: connectable ? Constants.yes : Constants.no)
            }
        }
        .transition(.opacity.combined(with: .scale))
    }
    
    private var advertisedDataSection: some View {
        VStack(spacing: 16) {
            Text(device.advertisedDataDescription)
                .font(.body)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
        }
        .transition(.opacity.combined(with: .scale))
    }
    
    private var locationSection: some View {
        VStack(spacing: 16) {
            if let location = device.location {
                DeviceLocationCardView(location: location)
            } else {
                EmptyDataView(
                    icon: "location.slash.fill",
                    message: Constants.locationUnavailable
                )
            }
        }
        .transition(.opacity.combined(with: .scale))
    }
    
}
