//
//  DirectionViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 11/08/2025.
//

import Foundation

@MainActor
@Observable
final class DirectionViewModel {
    var from = SelectionHistory(role: .from)
    var to = SelectionHistory(role: .to)
    
    private var fromCityStations: [Station] = []
    private var toCityStations: [Station] = []
    
    private(set) var selectedFromStation: Station?
    private(set) var selectedToStation:   Station?
    
    var shouldShowSearchButton: Bool {
        from.station != nil && to.station != nil
    }
    
    func setCity(_ city: String, code: String, stations: [Station], for role: DirectionRole) {
        if role == .from {
            from.city = city
            from.station = nil
            fromCityStations = stations
        } else {
            to.city = city
            to.station = nil
            toCityStations = stations
        }
    }
    
    /// Метод для получения станция на экране станций
    func stations(for role: DirectionRole) -> [Station] {
         role == .from ? fromCityStations : toCityStations
     }
    
    func setStation(_ station: Station, for role: DirectionRole) {
        if role == .from {
            from.station = station.title
            selectedFromStation = station
        } else {
            to.station = station.title
            selectedToStation = station
        }
    }
    
    func swapDirections() {
        swap(&from, &to)
        swap(&fromCityStations, &toCityStations)
        swap(&selectedFromStation, &selectedToStation)
    }
    
    func buildRouteInfo() -> RouteInfo {
        RouteInfo(
            fromCity: from.city ?? "",
            toCity: to.city ?? "",
            fromStation: from.station ?? "",
            toStation: to.station ?? ""
        )
    }
}
