//
//  StationSelectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 19/06/2025.
//

import SwiftUI
// На данном этапе разбираюсь как прокинуть станции сюда. Есть идея сделать DirectionView координатором и тогд аон соберет инфо на экране городе и передаст на эжкран станция.
// нужно ли оидельная модель для станций ?
struct StationSelectionView: View {
    @Binding var directionVM: DirectionViewModel
    @Binding var path: NavigationPath
    let role: DirectionRole
    
    @State private var stationSelectionVM: StationSelectionViewModel
    
    init(directionVM: Binding<DirectionViewModel>, path: Binding<NavigationPath>, role: DirectionRole) {
        self._directionVM = directionVM
        self._path = path
        self.role = role
        // берём подготовленные станции из DirectionVM
        let stations = directionVM.wrappedValue.stations(for: role)
        self._stationSelectionVM = State(initialValue: StationSelectionViewModel(stations: stations))
    }
    
    var body: some View {
        if stationSelectionVM.shouldShowNoResults {
            VStack { Spacer(); Text("NoStationTitle").titleStyle() }
        }
        
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(stationSelectionVM.searchResults, id: \.code) { station in
                    Button {
                        directionVM.setStation(station.title, for: role)
                        path = NavigationPath()
                    } label: {
                        HStack {
                            Text(station.title)
                            Spacer()
                            Image(.chevronIcon)
                        }
                        .padding()
                    }
                }
            }
            .searchable(text: $stationSelectionVM.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: Text("Search"))
        }
        .navigationTitle("Station selection")
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    @Previewable @State var directionVM = DirectionViewModel()
    @Previewable @State var path = NavigationPath()
    let role: DirectionRole = .from
    StationSelectionView(directionVM: $directionVM, path: $path, role: role)
}
