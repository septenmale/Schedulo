//
//  ArrivalView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 16/06/2025.
//

import SwiftUI

struct CitySelectionView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
        // Тут делаем List внутри NavStack при нажатии на елемент которого передаем в него выбранный город
        // К List применяем searchable. Переменную для которого уже создал
        }
        .searchable(text: $searchText, prompt: Text("Search"))

             
        
            .navigationTitle(Text("City selection"))
            .foregroundStyle(Color.appBlackDay)
            .toolbarRole(.editor)
            .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    CitySelectionView()
}
