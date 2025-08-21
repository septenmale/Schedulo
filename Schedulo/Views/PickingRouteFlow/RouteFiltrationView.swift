//
//  RouteFiltrationView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 27/06/2025.
//

import SwiftUI

/// Редактирует фильтр, напрямую меняя  вычисляемый vm.filtered в CarriersViewModel
struct RouteFiltrationView: View {
    let carriersVM: CarriersListViewModel
    
    private var shouldShowButton: Bool {
        !carriersVM.filterState.times.isEmpty && carriersVM.filterState.transfer != nil
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("DepartureTimeTitle")
                .titleStyle()
            ForEach(DepartureTime.allCases, id: \.self) { time in
                HStack {
                    Text(time.rawValue)
                    Spacer()
                    Button {
                        if carriersVM.filterState.times.contains(time) {
                            carriersVM.filterState.times.remove(time)
                        } else {
                            carriersVM.filterState.times.insert(time)
                        }
                    } label: {
                        Image(carriersVM.filterState.times.contains(time) ? .squareCheckmark : .square)
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .padding()
            Text("ShowTransferOptionsTitle")
                .titleStyle()
            ForEach(TransferFilter.allCases, id: \.self) { option in
                HStack {
                    Text(option.rawValue)
                    Spacer()
                    Button {
                        carriersVM.filterState.transfer = option
                    } label: {
                        Image(carriersVM.filterState.transfer == option ? .circleCheckmark : .circle)
                            .frame(width: 24, height: 24)
                    }
                    
                }
            }
            .padding()
            Spacer()
        }
        .padding()
        .toolbarRole(.editor)
        if shouldShowButton {
            NavigationLink {
                RouteDetailsView(carriersVM: carriersVM)
            } label: {
                Text("ApplyButtonTitle")
                    .frame(width: 343, height: 60)
                    .buttonStyle()
            }
            .padding()
        }
    }
}

#Preview {
    let info = RouteInfo(fromCity: "Москва", toCity: "Санкт Петербург", fromStation: "Ярославский вокзал", toStation: "Балтийский вокзал")
    let from: Station = .init(code: "123", title: "Ярославский вокзал")
    let to: Station = .init(code: "456", title: "Балтийский вокзал")
    let vm = CarriersListViewModel(route: info, fromStation: from, toStation: to)
    RouteFiltrationView(carriersVM: vm)
}
