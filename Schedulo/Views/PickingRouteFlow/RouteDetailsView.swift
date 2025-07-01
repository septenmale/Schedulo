//
//  RouteDetailsView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 27/06/2025.
//

import SwiftUI

struct RouteDetailsView: View {
    let filter: FilterState
    var routeInfo: RouteInfo
    
    /// Данная переменная прототип фильтрации. Если подходящий маршрутов нет - показываем заглушку
    var haveResults: Bool {
        true
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(routeInfo.fromCity) (\(routeInfo.fromStation)) -> \(routeInfo.toCity) (\(routeInfo.toStation))")
                .titleStyle()
            
            // Данный экземпляр в будущем будем получать из VM. По примеру из CarriersView + фильтр
            if haveResults {
                NavigationLink {
                    CarrierCard()
                }
                label: {
                    CarrierCellView(carrierInfo: CarrierCardInfo(
                        name: "РЖД",
                        date: "14 января",
                        departureTime: "22:30",
                        arrivalTime: "08:15",
                        time: "20 часов",
                        shouldTransfer: true)
                    )
                    .padding(.horizontal)
                }
            }
        }
        .padding()
        Spacer()
        if !haveResults {
            Text("NoOptionsString")
                .titleStyle()
        }
        Spacer()
        
        // Узнать что делает кнопка
        NavigationLink {
            Text("???")
        } label: {
            Text("CheckTimeButton")
                .frame(width: 343, height: 60)
                .buttonStyle()
        }
        .padding()
        .toolbarRole(.editor)
    }
}

#Preview {
    let filter = FilterState(times: [.evening, .night], transfer: .no)
    let info = RouteInfo(fromCity: "Москва", toCity: "Санкт Петербург", fromStation: "Ярославский вокзал", toStation: "Балтийский вокзал")
    RouteDetailsView(filter: filter, routeInfo: info)
}
