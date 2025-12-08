//
//  DeviceHeaderView.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//


import SwiftUI
import BLESDK

/// Header view displaying device icon and name.
struct DeviceHeaderView: View {
    let device: BLEDevice
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 100, height: 100)
                
                Image(systemName: Constants.antennaFillIcon)
                    .font(.system(size: 60))
                    .foregroundColor(.white)
            }
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            Text(device.name ?? Constants.unknownDevice)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            HStack(spacing: 8) {
                Image(systemName: Constants.wifi)
                Text("\(Constants.signal): \(device.rssi) " + Constants.rssiSuffix)
            }
            .font(.subheadline)
            .foregroundColor(.white.opacity(0.8))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.2))
            .cornerRadius(20)
        }
        .padding(.top, 20)
    }
}
