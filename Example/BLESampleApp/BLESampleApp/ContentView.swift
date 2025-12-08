//
//  ContentView.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BLEScannerViewModel()
    var body: some View {
           NavigationView {
               ZStack {
                   // Background gradient
                   LinearGradient(
                       gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing
                   )
                   .ignoresSafeArea()
                   
                   VStack(spacing: 20) {
                       // Header Section
                       HeaderSection(
                           deviceCount: viewModel.devices.count,
                           isScanning: viewModel.isScanning
                       )
                       
                       // Scan Control Buttons
                       ScanControlButtons(
                           isScanning: viewModel.isScanning,
                           onStartScan: { viewModel.startScan() },
                           onStopScan: { viewModel.stopScan() }
                       )
                       
                       // Device List Section
                       deviceListSection
                     
                   }
                   .padding()
               }
               .navigationBarHidden(true)
           }
       }
    
    private var deviceListSection: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text(Constants.nearbyDevices)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                if viewModel.isScanning {
                    ScanningIndicator()
                }
                
                if viewModel.devices.isEmpty && !viewModel.isScanning {
                    EmptyStateView()
                } else {
                    DeviceListView(devices: viewModel.devices, viewModel: viewModel)
                }
            }
        }
}

#Preview {
    ContentView()
}
