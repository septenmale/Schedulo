//
//  RouteDetailsView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 27/06/2025.
//

import SwiftUI

/// Смотрит вычисляемый vm.filtered в CarriersViewModel и рэндэрит результат
struct RouteDetailsView: View {
    let carriersVM: CarriersListViewModel
    
    var haveResults: Bool {
        //        false
        !carriersVM.filtered.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Title
            Text("\(carriersVM.route.fromCity) (\(carriersVM.route.fromStation)) -> \(carriersVM.route.toCity) (\(carriersVM.route.toStation))")
                .titleStyle()
                .padding(.horizontal, 16)
                .padding(.top, 16)
            
            if haveResults {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ForEach(carriersVM.filtered) { card in
                            NavigationLink {
                                CarrierCard(carrier: card)
                            } label: {
                                CarrierCellView(carrierInfo: card)
                                    .listRowSeparator(.hidden)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
                .safeAreaInset(edge: .bottom) {
                    NavigationLink {
                        Text("???")
                    } label: {
                        Text("CheckTimeButton")
                            .frame(width: 343, height: 60)
                            .buttonStyle()
                    }
                }
                .padding(.bottom,16)
            } else {
                Spacer()
                Text("NoOptionsString")
                    .titleStyle()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 16)
                Spacer()
            }
        }
        .toolbarRole(.editor)
    }
}

#Preview {
    let info = RouteInfo(fromCity: "Москва", toCity: "Санкт Петербург", fromStation: "Ярославский вокзал", toStation: "Балтийский вокзал")
    let from: Station = .init(code: "123", title: "Ярославский вокзал")
    let to: Station = .init(code: "456", title: "Балтийский вокзал")
    let vm = CarriersListViewModel(route: info, fromStation: from, toStation: to)
    RouteDetailsView(carriersVM: vm)
}
