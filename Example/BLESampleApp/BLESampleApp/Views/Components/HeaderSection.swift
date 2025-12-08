//
//  HeaderSection.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//


import SwiftUI

/// Header section displaying app title and device count with animated icon.
struct HeaderSection: View {
    let deviceCount: Int
    let isScanning: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: Constants.antennaIcon)
                .font(.system(size: 60))
                .foregroundColor(.white)
                .rotationEffect(.degrees(isScanning ? 360 : 0))
                .animation(
                    isScanning ? Animation.linear(duration: 2).repeatForever(autoreverses: false) : .default,
                    value: isScanning
                )
            
            Text(Constants.bleScanner)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
            
            Text("\(deviceCount) \(Constants.devicesFound)")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.top, 40)
    }
}
