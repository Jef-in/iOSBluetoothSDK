//
//  DeviceLocationCardView.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//


import SwiftUI
import BLESDK

/// Card view displaying device location coordinates and accuracy.
struct DeviceLocationCardView: View {
    let location: LocationData
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: Constants.locationFillIcon)
                    .foregroundColor(.white)
                Text(Constants.coordinatesLabel)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(Constants.latitudeLabel)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text(String(format: "%.6f", location.latitude))
                        .font(.body)
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(Constants.longitudeLabel)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text(String(format: "%.6f", location.longitude))
                        .font(.body)
                        .foregroundColor(.white)
                }
            }
            HStack {
                Text(Constants.altitudeLabel)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                Spacer()
                Text(String(format: "%.2f m", location.altitude ?? 0.0))
                    .font(.body)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
    }
}
