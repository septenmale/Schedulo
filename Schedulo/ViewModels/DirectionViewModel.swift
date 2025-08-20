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
    
    private var fromCityCode: String?
    private var toCityCode: String?
    private var fromCityStations: [Station] = []
    private var toCityStations: [Station] = []
    
    var shouldShowSearchButton: Bool {
        from.station != nil && to.station != nil
    }
    
    func setCity(_ city: String, code: String, stations: [Station], for role: DirectionRole) {
        if role == .from {
            from.city = city
            from.station = nil
            fromCityCode = code
            fromCityStations = stations
        } else {
            to.city = city
            to.station = nil
            toCityCode = code
            toCityStations = stations
        }
    }
    
    /// Метод для получения станция на экране станций
    func stations(for role: DirectionRole) -> [Station] {
         role == .from ? fromCityStations : toCityStations
     }
    
    func setStation(_ station: String, for role: DirectionRole) {
        if role == .from {
            from.station = station
        } else {
            to.station = station
        }
    }
    
    func swapDirections() {
        swap(&from, &to)
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
