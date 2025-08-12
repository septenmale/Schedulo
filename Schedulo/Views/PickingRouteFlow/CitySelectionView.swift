//
//  ArrivalView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 16/06/2025.
//

import SwiftUI

struct CitySelectionView: View {
    
    //TODO: Вынести в VM для данного экрана
    let cities = ["Москва", "Санкт-Петербург", "Сочи", "Горный воздух", "Краснодар", "Казань", "Омск"]
    
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
                Text("NoCityTitle")
                    .titleStyle()
            }
        }
        
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(searchResults, id: \.self) { cityName in
                    Button {
                        path.append(SelectionHistory(role: role,city: cityName))
                        directionVM.setCity(cityName, for: role)
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
        searchText.isEmpty ? cities : cities.filter { $0.contains(searchText) }
    }
}

#Preview {
    @Previewable @State var directionVM = DirectionViewModel()
    @Previewable @State var path = NavigationPath()
    let role: DirectionRole = .from
    CitySelectionView(path: $path, directionVM: $directionVM, role: role)
}
