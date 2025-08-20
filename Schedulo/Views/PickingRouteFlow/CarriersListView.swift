//
//  CarriersView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 23/06/2025.
//

import SwiftUI
//TODO: Стоит здесь и на экранах похоже типа поправить отсупы. Между заголовка, от краев экрана и тд. По ощущениям слишком много.

struct CarriersListView: View {
    @State private var carriersVM: CarriersViewModel
    
    init(routeInfo: RouteInfo) {
        _carriersVM = State(initialValue: CarriersViewModel(route: routeInfo))
    }
    
    var body: some View {
        VStack() {
            Text("\(carriersVM.route.fromCity) (\(carriersVM.route.fromStation)) -> \(carriersVM.route.toCity) (\(carriersVM.route.toStation))")
                .titleStyle()
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(carriersVM.all) { card in
                        NavigationLink {
                            CarrierCard(carrier: card)
                        } label: {
                            CarrierCellView(carrierInfo: card)
                                .listRowSeparator(.hidden)
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                NavigationLink {
                    RouteFiltrationView(carriersVM: carriersVM)
                } label: {
                    Text("CheckTimeButton")
                        .frame(width: 343, height: 60)
                        .buttonStyle()
                }
            }
        }
        .padding()
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    let info = RouteInfo(fromCity: "Москва", toCity: "Санкт Петербург", fromStation: "Ярославский вокзал", toStation: "Балтийский вокзал")
    CarriersListView(routeInfo: info)
}
