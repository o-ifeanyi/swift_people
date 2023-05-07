//
//  SettingsView.swift
//  People
//
//  Created by Ifeanyi Onuoha on 28/04/2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(UserDefaultKeys.isHapticOn) private var isHapticOn: Bool = true
    var body: some View {
        ZStack(alignment: .topLeading) {
            Theme.background.ignoresSafeArea()
            
            VStack {
                Toggle("Haptic Feedback", isOn: $isHapticOn)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(Theme.onBackground)
                    .cornerRadius(10)
            }
            .padding()
            .navigationTitle("Settings")
        }
        .embedNavigation()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
