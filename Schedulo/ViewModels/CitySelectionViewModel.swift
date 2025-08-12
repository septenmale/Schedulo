//
//  CitySelectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 12/08/2025.
//

import Foundation

@Observable
final class CitySelectionViewModel {
    let cities = ["Москва", "Санкт-Петербург", "Сочи", "Горный воздух", "Краснодар", "Казань", "Омск"]
    var searchText = ""
    
    //TODO: поправить чтобы искало с маленькой буквы начиная и не учитывало пробелы перед
    var searchResults: [String] {
        searchText.isEmpty ? cities : cities.filter { $0.contains(searchText) }
    }
    
    var shouldShowNoResults: Bool {
        searchResults.isEmpty
    }
}
