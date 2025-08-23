//
//  CarriersViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 13/08/2025.
//

import Foundation
import OpenAPIURLSession

// Если пометитить VM как MainActor то все экземплярные свойства и методы этой VM изолированы главным актором.
// Это значит что Любая тяжёлая синхронная работа внутри такой VM будет блокировать главный поток — @MainActor не делает её волшебно фоновой.
// Поэтому тяжелую работу стоит выносить в сервисы

// nonisolated-метод в @MainActor VM — допустимая «лайт-альтернатива» сервису в маленьких проектах. Но он жёстко ограничен: не трогает self, требует Sendable данных и легко превращается в «скрытый сервис», который хуже тестируется. Для масштабируемости — отдельный сервис по протоколу остаётся более надёжным выбором.

@MainActor
@Observable
final class CarriersListViewModel {
    let route: RouteInfo
    var fromStation: Station
    var toStation: Station
    
    private(set) var allCarrierCards: [CarrierCardInfo] = []
    var shouldShowNoResults: Bool {
        allCarrierCards.isEmpty
    }
    
    var filterState = FilterState(times: [], transfer: nil)
    
    // Возвращаю пока полный список. Позже добавлю логику фильтрации
    var filtered: [CarrierCardInfo] {
        allCarrierCards
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
    
    private func mapToCarrierCards(_ response: RoutesBetweenStations) -> [CarrierCardInfo] {
        let segments = response.segments ?? []
        return segments.map { segment in
            let thread = segment.thread
            let id = thread?.uid ?? UUID().uuidString
            let name = thread?.carrier?.title ?? thread?.title ?? "Unknown"
            let carrierCode =
            thread?.carrier?.codes?.iata ??
            thread?.carrier?.codes?.icao ??
            thread?.number ?? "N/A"
            
            let logoURL: URL?
            if let logo = thread?.carrier?.logo, !logo.isEmpty {
                logoURL = URL(string: logo.hasPrefix("http") ? logo : "https:\(logo)")
            } else {
                logoURL = nil
            }
            
            return CarrierCardInfo(
                id: id,
                name: name,
                carrierCode: carrierCode,
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
    
    private func fetchAllRoutes() async throws -> [CarrierCardInfo] {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = RoutesBetweenStationsService(
            client: client,
            apikey: appKeys.yandexRaspAPIKey.rawValue
        )
        
        let response = try await service.getRoutesBetweenStations(
            //TODO: Заменить на динамические данные
            from: fromStation.code,
            to: toStation.code,
        )
        
        return mapToCarrierCards(response)
    }
}
