//
//  ContentView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 29/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var error: ErrorType? = nil
    @Binding var settingsVM: SettingsViewModel
    
   private var colorScheme: ColorScheme? {
        switch settingsVM.selectedAppearance {
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
                NavigationStack {
                    DirectionView()
                }
                .tabItem {
                    Image(.directionIcon)
                        .renderingMode(.template)
                }
                SettingsView(settingsVM: $settingsVM)
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
    @Previewable @State var settingsVM = SettingsViewModel()
    ContentView(settingsVM: $settingsVM)
}
