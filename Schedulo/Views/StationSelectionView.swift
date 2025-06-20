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
    let stations = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    @State private var searchText = ""
    
    var body: some View {
        // Тут убрал NavStack но он вроде как не нужен если есть на корневом вью
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(searchResult, id: \.self) { station in
                        Button {
                            emptyAction()
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
    // Через кнопку следует передать выбранный город и станцию
    func emptyAction() {
        print("Button did tap")
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
    StationSelectionView(city: "Москва")
}
