//
//  DirectionViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 11/08/2025.
//

import Foundation

@Observable
final class DirectionViewModel {
    var from = SelectionHistory(role: .from)
    var to = SelectionHistory(role: .to)
    
    var shouldShowSearchButton: Bool {
        from.station != nil && to.station != nil
    }
    
    func setCity(_ city: String, for role: DirectionRole) {
        if role == .from {
            from.city = city
            from.station = nil
        } else {
            to.city = city
            to.station = nil
        }
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
