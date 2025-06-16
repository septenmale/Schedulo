//
//  ContentView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 29/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DirectionView()
                .tabItem {
                    Image(.directionIcon)
                        .renderingMode(.template)
                }
            SettingsView()
                .tabItem {
                    Image(.settingsIcon)
                        .renderingMode(.template)
                }
        }
        .accentColor(.appBlackDay)
    }
}

#Preview {
    ContentView()
}
