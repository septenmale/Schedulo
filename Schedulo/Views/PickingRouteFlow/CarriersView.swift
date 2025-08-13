//
//  CarriersView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 23/06/2025.
//

import SwiftUI

struct CarriersView: View {
    @State private var carriersVM: CarriersViewModel
    let routeInfo: RouteInfo
    
    init(routeInfo: RouteInfo) {
        self.routeInfo = routeInfo
        _carriersVM = State(initialValue: CarriersViewModel(route: routeInfo))
    }
    
    var body: some View {
        VStack() {
            Text("\(routeInfo.fromCity) (\(routeInfo.fromStation)) -> \(routeInfo.toCity) (\(routeInfo.toStation))")
                .titleStyle()
            NavigationLink {
                CarrierCard()
            }
            label: {
                List(carriersVM.listOfCarriers) { card in
                    CarrierCellView(carrierInfo: card)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .safeAreaInset(edge: .bottom) {
                NavigationLink {
                    RouteFiltrationView(routeInfo: routeInfo)
                } label: {
                    Text("CheckTimeButton")
                        .frame(width: 343, height: 60)
                        .buttonStyle()
                }
            }
        }
        .frame(width: 360)
        .padding()
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    let info = RouteInfo(fromCity: "Москва", toCity: "Санкт Петербург", fromStation: "Ярославский вокзал", toStation: "Балтийский вокзал")
    CarriersView(routeInfo: info)
}
