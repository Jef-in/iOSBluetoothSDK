//
//  DeviceInfoCardView.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//


import SwiftUI

/// Card view for displaying device information with an icon and label.
struct DeviceInfoCardView: View {
    let icon: String
    let title: String
    let value: String
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 40)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                Text(value)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
    }
}
