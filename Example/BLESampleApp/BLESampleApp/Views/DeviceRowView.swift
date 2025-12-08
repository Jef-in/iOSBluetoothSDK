//
//  DeviceRowView.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//


import SwiftUI
import BLESDK

struct DeviceRowView: View {
    let device: BLEDevice
    
    var body: some View {
        HStack(spacing: 16) {
            // Device Icon
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 50, height: 50)
                
                Image(systemName: Constants.cpu)
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            // Device Info
            VStack(alignment: .leading, spacing: 4) {
                Text(device.name ?? Constants.unknownDevice)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(device.id.uuidString.prefix(18) + Constants.dots)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                
                HStack(spacing: 4) {
                    Image(systemName: signalStrengthIcon(for: device.rssi))
                        .font(.caption)
                    Text("\(device.rssi) " + Constants.rssiSuffix)
                        .font(.caption)
                }
                .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
            
            Image(systemName: Constants.arrow)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.2))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    private func signalStrengthIcon(for rssi: Int) -> String {
        if rssi > -60 {
            return Constants.wifi
        } else if rssi > -70 {
            return Constants.wifiOut
        } else {
            return Constants.wifiSlash
        }
    }
}
