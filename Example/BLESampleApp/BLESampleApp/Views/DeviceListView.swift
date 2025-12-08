//
//  DeviceListView.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//


import SwiftUI
import BLESDK

/// Scrollable list of discovered BLE devices with animated transitions.
struct DeviceListView: View {
    let devices: [BLEDevice]
    @ObservedObject var viewModel: BLEScannerViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(Array(devices.enumerated()), id: \.element.id) { index, device in
                    NavigationLink(destination: DeviceDetailView(device: device, viewModel: viewModel)) {
                        DeviceRowView(device: device)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .opacity
                    ))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(Double(index) * 0.05), value: devices.count)
                }
            }
            .padding(.horizontal)
        }
    }
}
