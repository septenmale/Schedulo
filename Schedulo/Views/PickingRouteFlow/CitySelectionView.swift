//
//  ArrivalView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 16/06/2025.
//

import SwiftUI

//TODO: Изначально, пока не загрузился список появляется заглушка - поправить!
struct CitySelectionView: View {
    @State private var citySelectionVM = CitySelectionViewModel()
    @Binding var path: NavigationPath
    @Binding var directionVM: DirectionViewModel
    
    @State private var showList = true
    
    let role: DirectionRole
    
    var body: some View {
        if citySelectionVM.shouldShowNoResults {
            VStack {
                Spacer()
                Text("NoCityTitle")
                    .titleStyle()
            }
        }
        
        Group {
            if showList {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(citySelectionVM.searchResults, id: \.code) { city in
                            Button {
                                let stations = citySelectionVM.stations(for: city.code)
                                directionVM.setCity(city.title, code: city.code, stations: stations, for: role)
                                
                                showList = false
                                path.append(SelectionHistory(role: role, city: city.title))
                            } label: {
                                HStack {
                                    Text(city.title)
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
            }
        }
        .navigationTitle(Text("City selection"))
        .foregroundStyle(Color.appBlackDay)
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
        .task {
            await citySelectionVM.fetchCities()
        }
        .onAppear { showList = true }
        .onDisappear { showList = false }
    }
}

#Preview {
    @Previewable @State var directionVM = DirectionViewModel()
    @Previewable @State var path = NavigationPath()
    let role: DirectionRole = .from
    CitySelectionView(path: $path, directionVM: $directionVM, role: role)
}
