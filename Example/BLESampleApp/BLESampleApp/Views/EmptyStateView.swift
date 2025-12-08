//
//  EmptyStateView.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//


import SwiftUI

/// Empty state view displayed when no devices are found.
struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: Constants.wifiSlash)
                .font(.system(size: 50))
                .foregroundColor(.white.opacity(0.6))
            Text(Constants.emptyState)
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
