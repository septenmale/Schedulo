//
//  ScheduloApp.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 29/05/2025.
//

import SwiftUI

@main
struct ScheduloApp: App {
    @State private var settingsVM = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(settingsVM: $settingsVM)
        }
    }
}
