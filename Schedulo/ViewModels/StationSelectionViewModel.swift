//
//  StationSelectionViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 12/08/2025.
//

import Foundation

@MainActor
@Observable
final class StationSelectionViewModel {
    private let stations: [Station]
    var searchText = ""
    
    init(stations: [Station]) {
        self.stations = stations
    }
    
    var searchResults: [Station] {
        searchText.isEmpty ? stations : stations.filter { $0.title.localizedCaseInsensitiveContains(searchText.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    
    var shouldShowNoResults: Bool {
        searchResults.isEmpty
    }
}
