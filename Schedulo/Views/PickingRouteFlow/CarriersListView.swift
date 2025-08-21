//
//  CarriersView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 23/06/2025.
//

import SwiftUI

//TODO: Стоит здесь и на экранах похоже типа поправить отсупы. Между заголовка, от краев экрана и тд. По ощущениям слишком много.
struct CarriersListView: View {
    @State private var carriersVM: CarriersListViewModel
    // Если уже передаю ВМ целиком то routeInfo можно также получать из нее
    var directionVM: DirectionViewModel
    
    init(routeInfo: RouteInfo, directionVM: DirectionViewModel) {
        // От рута избавится получать его с помощью directionVM.buildRouteInfo()
        guard let from = directionVM.selectedFromStation,
              let to   = directionVM.selectedToStation else {
            // здесь можно кинуть preconditionFailure или показать заглушку
            fatalError("Stations must be selected before opening CarriersListView")
        }
        
        _carriersVM = State(initialValue: CarriersListViewModel(
            route: routeInfo,
            fromStation: from,
            toStation: to
        ))
        self.directionVM = directionVM
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
        .onAppear {
            print("Станция откуда: \(String(describing: directionVM.selectedFromStation)) станция куда: \(String(describing: directionVM.selectedToStation))")
        }
        .task {
            await carriersVM.testData()
        }
    }
}

#Preview {
    let vm = DirectionViewModel()
    let info = RouteInfo(fromCity: "Москва", toCity: "Санкт Петербург", fromStation: "Ярославский вокзал", toStation: "Балтийский вокзал")
    CarriersListView(routeInfo: info, directionVM: vm)
}
