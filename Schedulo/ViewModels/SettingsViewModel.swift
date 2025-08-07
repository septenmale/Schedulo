//
//  SettingsViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 07/08/2025.
//

import Foundation

@Observable
final class SettingsViewModel {
    var selectedAppearance: Appearance {
        didSet { defaults.setValue(selectedAppearance.rawValue, forKey: key) }
    }
    
    var isDarkMode: Bool {
        get { selectedAppearance == .dark }
        set { selectedAppearance = newValue ? .dark : .light }
    }
    
    private let key = "appearance"
    private let defaults = UserDefaults.standard
    
    /// @Observable не работает с computed property - нужно чтобы получить значение после инициализации defaults
    init() {
        let rawValue = defaults.string(forKey: key)
        self.selectedAppearance = Appearance(rawValue: rawValue ?? "appearance") ?? .system
    }
}
