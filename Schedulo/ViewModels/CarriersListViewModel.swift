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
    
    init(route: RouteInfo, fromStation: Station, toStation: Station) {
        self.route = route
        self.fromStation = fromStation
        self.toStation = toStation
    }
    
    func testData() async {
        do {
            let response = try await fetchAllRoutes()
            print("✅ Response:", response)
        } catch {
            print("❌ Error:", error)
        }
    }
    
    private func fetchAllRoutes() async throws -> RoutesBetweenStations {
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
            from: "c146",
            to: "c213",
        )
        
        return response
    }
}
