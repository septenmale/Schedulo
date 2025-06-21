//
//  StationSelectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 19/06/2025.
//

import SwiftUI

struct StationSelectionView: View {
    /// stores value of selected city
    let city: String
    var isFrom: Bool
    
    let stations = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    @State private var searchText = ""
    @Binding var path: NavigationPath
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(searchResult, id: \.self) { station in
                        Button {
                            path = NavigationPath()
                        } label: {
                            HStack {
                                Text(station)
                                Spacer()
                                Image(.chevronIcon)
                            }
                            .padding()
                        }
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search"))
            }
        
        .navigationTitle("Station selection")
        .toolbarRole(.editor)
    }
    
    // Повторяется в двух View. Подумать над этим
    var searchResult: [String] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { $0.contains(searchText) }
        }
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    StationSelectionView(city: "Москва", isFrom: true, path: $path)
}
