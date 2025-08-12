//
//  StationSelectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 19/06/2025.
//

import SwiftUI

struct StationSelectionView: View {
    @State private var stationSelectionVM = StationSelectionViewModel()
    @Binding var directionVM: DirectionViewModel
    @Binding var path: NavigationPath
    
    let role: DirectionRole
    
    var body: some View {
        if stationSelectionVM.shouldShowNoResults {
            VStack {
                Spacer()
                Text("NoStationTitle")
                    .titleStyle()
            }
        }
        
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(stationSelectionVM.searchResults, id: \.self) { station in
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
            .searchable(text: $stationSelectionVM.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search"))
        }
        .navigationTitle("Station selection")
        .toolbarRole(.editor)
    }
}

#Preview {
    @Previewable @State var directionVM = DirectionViewModel()
    @Previewable @State var path = NavigationPath()
    let role: DirectionRole = .from
    StationSelectionView(directionVM: $directionVM, path: $path, role: role)
}
