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
    
    var body: some View {
        // Тут убрал NavStack но он вроде как не нужен если есть на корневом вью
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(searchResults, id: \.self) { name in
                        NavigationLink(destination: StationSelectionView(city: name)) {
                            HStack {
                                Text(name)
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundStyle(Color.appBlackDay)
                                Spacer()
                                Image(.chevronIcon)
                            }
                            .padding()
                            
                        }
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search"))
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

    //TODO: Добавить город не найден в случае если не совпадает с поиском.
    // Поправить TabBar при возврате на главный экран ( появляется обратно с задержкой )

#Preview {
    CitySelectionView()
}
