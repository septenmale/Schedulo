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
    
    //Новая логика
    @Binding var directionVM: DirectionViewModel
    //Должна ли быть байдингом?
    let role: DirectionRole
    
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
                        directionVM.setStation(station, for: role)
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
    @Previewable @State var directionVM = DirectionViewModel()
    @Previewable @State var path = NavigationPath()
    let role: DirectionRole = .from
    StationSelectionView(path: $path, directionVM: $directionVM, role: role)
}
