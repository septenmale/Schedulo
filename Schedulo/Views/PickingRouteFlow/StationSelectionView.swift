//
//  StationSelectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 19/06/2025.
//

import SwiftUI

struct StationSelectionView: View {
    
    //TODO: Вынести из View
    let stations = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    
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
                Text("NoStationTitle")
                    .titleStyle()
            }
        }
        
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(searchResults, id: \.self) { station in
                    Button {
                        selectionHistory.station = station
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
    var searchResults: [String] {
        searchText.isEmpty ? stations : stations.filter { $0.contains(searchText) }
    }
}

#Preview {
    @Previewable @State var history = SelectionHistory(role: .from)
    @Previewable @State var path = NavigationPath()
    StationSelectionView(path: $path, selectionHistory: $history)
}
