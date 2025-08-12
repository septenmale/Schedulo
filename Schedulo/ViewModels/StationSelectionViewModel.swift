//
//  StationSelectionViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 12/08/2025.
//

import Foundation

@Observable
final class StationSelectionViewModel {
    let stations = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    var searchText = ""
    
    var searchResults: [String] {
        searchText.isEmpty ? stations : stations.filter { $0.contains(searchText) }
    }
    
    var shouldShowNoResults: Bool {
        searchResults.isEmpty
    }
}
