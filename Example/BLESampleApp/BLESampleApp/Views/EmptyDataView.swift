//
//  EmptyDataView.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//

import SwiftUI

struct EmptyDataView: View {
    var icon: String
    var message: String
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(.white.opacity(0.4))
            Text(message)
                .font(.headline)
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .padding(40)
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
    }
}
