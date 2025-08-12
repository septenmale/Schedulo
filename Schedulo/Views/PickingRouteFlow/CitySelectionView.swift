//
//  ArrivalView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 16/06/2025.
//

import SwiftUI

struct CitySelectionView: View {
    @State private var citySelectionVM = CitySelectionViewModel()
    @Binding var path: NavigationPath
    @Binding var directionVM: DirectionViewModel
    
    let role: DirectionRole
    
    var body: some View {
        if citySelectionVM.shouldShowNoResults {
            VStack {
                Spacer()
                Text("NoCityTitle")
                    .titleStyle()
            }
        }
        
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(citySelectionVM.searchResults, id: \.self) { cityName in
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
                text: $citySelectionVM.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("Search")
            )
        }
        .navigationTitle(Text("City selection"))
        .foregroundStyle(Color.appBlackDay)
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    @Previewable @State var directionVM = DirectionViewModel()
    @Previewable @State var path = NavigationPath()
    let role: DirectionRole = .from
    CitySelectionView(path: $path, directionVM: $directionVM, role: role)
}
