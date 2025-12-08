//
//  ScanControlButtons.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//


import SwiftUI

/// Control buttons for starting and stopping BLE device scanning.
struct ScanControlButtons: View {
    let isScanning: Bool
    let onStartScan: () -> Void
    let onStopScan: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                withAnimation(.spring()) {
                    onStartScan()
                }
            }) {
                HStack {
                    Image(systemName: Constants.playIcon)
                        Text(Constants.startScan)
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green, Color.green.opacity(0.8)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(15)
                .shadow(color: Color.green.opacity(0.4), radius: 10, x: 0, y: 5)
            }
            .disabled(isScanning)
            .opacity(isScanning ? 0.6 : 1.0)
            
            Button(action: {
                withAnimation(.spring()) {
                    onStopScan()
                }
            }) {
                HStack {
                    Image(systemName: Constants.stopIcon)
                        Text(Constants.stopScan)
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red, Color.red.opacity(0.8)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(15)
                .shadow(color: Color.red.opacity(0.4), radius: 10, x: 0, y: 5)
            }
            .disabled(!isScanning)
            .opacity(!isScanning ? 0.6 : 1.0)
        }
        .padding(.horizontal)
    }
}
