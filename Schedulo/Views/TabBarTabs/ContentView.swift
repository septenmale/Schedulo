//
//  ContentView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 29/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var error: ErrorType? = nil
    @AppStorage("appearance") private var selectedAppearance: Appearance = .system
    
    var colorScheme: ColorScheme? {
        switch selectedAppearance {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
    
    var body: some View {
        
        if let error {
            ErrorView(
                imageName: error.imageName,
                title: error.title
            )
        } else {
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
            .preferredColorScheme(colorScheme)
        }
            
    }
}

#Preview {
    ContentView()
}
