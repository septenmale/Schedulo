//
//  CarriersViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 13/08/2025.
//

import Foundation

@Observable
final class CarriersViewModel {
    let route: RouteInfo
    
    private(set) var all: [CarrierCardInfo] = [
        CarrierCardInfo(name: "РЖД", date: "14 января", departureTime: "22:30", arrivalTime: "08:15", time: "20 часов", shouldTransfer: true),
        CarrierCardInfo(name: "ФГК", date: "15 января", departureTime: "01:15", arrivalTime: "09:00", time: "20 часов", shouldTransfer: false),
        CarrierCardInfo(name: "Урал логистика", date: "16 января", departureTime: "12:30", arrivalTime: "21:00", time: "9 часов", shouldTransfer: false),
        CarrierCardInfo(name: "РЖД", date: "17 января", departureTime: "22:30", arrivalTime: "08:15", time: "20 часов", shouldTransfer: true),
        CarrierCardInfo(name: "РЖД", date: "17 января", departureTime: "22:30", arrivalTime: "08:15", time: "20 часов", shouldTransfer: true),
        CarrierCardInfo(name: "РЖД", date: "17 января", departureTime: "23:15", arrivalTime: "09:40", time: "20 часов", shouldTransfer: false)
    ]
    
    var filterState = FilterState(times: [], transfer: nil)
    
    // Возвращаю пока полный список. Позже добавлю логику фильтрации
    var filtered: [CarrierCardInfo] {
        all
    }
    
    init(route: RouteInfo) {
        self.route = route
    }
}
