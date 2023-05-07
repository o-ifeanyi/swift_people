//
//  ContentView.swift
//  People
//
//  Created by Ifeanyi Onuoha on 28/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PeopleView()
                .tabItem {
                    Symbols.person
                        .accessibilityIdentifier("peopleTab")
                    Text("Home")
                }
            
            SettingsView()
                .tabItem {
                    Symbols.gear
                        .accessibilityIdentifier("settingsTab")
                    Text("Settings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
