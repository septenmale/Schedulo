//
//  CarriersViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 13/08/2025.
//

import Foundation
import OpenAPIURLSession

@MainActor
@Observable
final class CarriersListViewModel {
    let route: RouteInfo
    var fromStation: Station
    var toStation: Station
    
    private(set) var allCarrierCards: [RouteDetailsModel] = []
    var shouldShowNoResults: Bool {
        allCarrierCards.isEmpty
    }
    
    var filterState = FilterState(times: [], transfer: nil)
    
    var filtered: [RouteDetailsModel] {
        allCarrierCards.filter { card in
            matchesTimeBuckets(card) && matchesTransfer(card)
        }
    }
    
    init(route: RouteInfo, fromStation: Station, toStation: Station) {
        self.route = route
        self.fromStation = fromStation
        self.toStation = toStation
    }
    
    func getCarriersCards() async {
        do {
            let carriers = try await fetchAllRoutes()
            allCarrierCards = carriers
            print("✅ Loaded carriers:", carriers)
        } catch {
            print("❌ Error:", error)
        }
    }
    
    private func matchesTransfer(_ card: RouteDetailsModel) -> Bool {
        guard let choice = filterState.transfer else { return true }
        switch choice {
        case .yes: return card.hasTransfers
        case .no:  return !card.hasTransfers
        }
    }
    
    private func matchesTimeBuckets(_ card: RouteDetailsModel) -> Bool {
        if filterState.times.isEmpty { return true }
        guard let dep = card.departureDate else { return false }
        
        let hour = Calendar.current.component(.hour, from: dep)
        let bucket: DepartureTime
        switch hour {
        case 6..<12:   bucket = .morning   // 06:00–11:59
        case 12..<18:  bucket = .day       // 12:00–17:59
        case 18..<24:  bucket = .evening   // 18:00–23:59
        default:       bucket = .night     // 00:00–05:59
        }
        return filterState.times.contains(bucket)
    }
    
    private func mapToCarrierCards(_ response: RoutesBetweenStations) -> [RouteDetailsModel] {
        let segments = response.segments ?? []
        return segments.map { segment in
            let thread = segment.thread
            let id = thread?.uid ?? UUID().uuidString
            let name = thread?.carrier?.title ?? thread?.title ?? "Unknown"
            let carrierCode = thread?.carrier?.code ?? 63438
            
            let logoURL: URL?
            if let logo = thread?.carrier?.logo, !logo.isEmpty {
                logoURL = URL(string: logo.hasPrefix("http") ? logo : "https:\(logo)")
            } else {
                logoURL = nil
            }
            
            return RouteDetailsModel(
                id: id,
                name: name,
                carrierCode: String(carrierCode),
                logoURL: logoURL,
                fromTitle: segment.from?.title ?? "Unknown",
                toTitle: segment.to?.title ?? "Unknown",
                departureRaw: segment.departure ?? "",
                arrivalRaw: segment.arrival ?? "",
                durationSeconds: segment.duration ?? 0,
                hasTransfers: segment.has_transfers ?? false
            )
        }
    }
    
    private func fetchAllRoutes() async throws -> [RouteDetailsModel] {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = RoutesBetweenStationsService(
            client: client,
            apikey: appKeys.yandexRaspAPIKey.rawValue
        )
        
        let response = try await service.getRoutesBetweenStations(
            from: fromStation.code,
            to: toStation.code,
        )
        
        return mapToCarrierCards(response)
    }
}
