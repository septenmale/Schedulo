//
//  ArrivalView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 16/06/2025.
//

import SwiftUI

struct CitySelectionView: View {
    
    //TODO: Вынести из View
    let cities = ["Москва", "Санкт-Петербург", "Сочи", "Горный воздух", "Краснодар", "Казань", "Омск"]
    
    @State private var searchText = ""
    @Binding var path: NavigationPath
    @Binding var selectionHistory: SelectionHistory
    var shouldShowNoResults: Bool {
        searchResults.isEmpty
    }
    
    var body: some View {
        
        if shouldShowNoResults {
            VStack {
                Spacer()
                Text("NoCityTitle")
                    .titleStyle()
            }
        }
        
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(searchResults, id: \.self) { cityName in
                    Button {
                        path.append(SelectionHistory(role: selectionHistory.role, city: cityName))
                        selectionHistory.city = cityName
                    } label: {
                        HStack {
                            Text(cityName)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(Color.appBlackDay)
                            Spacer()
                            Image(.chevronIcon)
                        }
                        .padding()
                    }
                }
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("Search")
            )
        }
        .navigationTitle(Text("City selection"))
        .foregroundStyle(Color.appBlackDay)
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.contains(searchText) }
        }
    }
}

#Preview {
    @Previewable @State var history = SelectionHistory(role: .from)
    
    @Previewable @State var path = NavigationPath()
    CitySelectionView(path: $path, selectionHistory: $history)
}
