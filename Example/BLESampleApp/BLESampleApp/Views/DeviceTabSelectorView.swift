//
//  DeviceTabSelectorView.swift
//  BLESampleApp
//
//  Created by Jefin Abdul Jaleel on 28/11/25.
//


import SwiftUI

/// Tab selector for switching between device information views.
struct DeviceTabSelectorView: View {
    @Binding var selectedTab: Int
    var body: some View {
        HStack(spacing: 0) {
            tabButton(title: Constants.generalTab, index: 0, icon: Constants.infoIcon)
            tabButton(title: Constants.dataTab, index: 1, icon: Constants.docIcon)
            tabButton(title: Constants.locationTab, index: 2, icon: Constants.locationFillIcon)
        }
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
    }
    
    private func tabButton(title: String, index: Int, icon: String) -> some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = index
            }
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.title3)
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(selectedTab == index ? .white : .white.opacity(0.6))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                selectedTab == index ?
                    AnyView(LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )) :
                    AnyView(Color.clear)
            )
            .cornerRadius(12)
        }
    }
}
