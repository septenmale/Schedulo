//
//  RoutesFromStationService.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 07/06/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias RoutesFromStation = Components.Schemas.ScheduleResponse

protocol RoutesFromStationServiceProtocol {
    func getRoutesFromStation(from: String) async throws -> RoutesFromStation
}

final class RoutesFromStationService: RoutesFromStationServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRoutesFromStation(from station: String) async throws -> RoutesFromStation {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station
        ))
        
        return try response.ok.body.json
    }
}

func testFetchRoutesFromStation() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = RoutesFromStationService(
                client: client,
                apikey: appKeys.yandexRaspAPIKey.rawValue
            )
            
            print("Fetching routes from station...")
            let response = try await service.getRoutesFromStation(
                from: "s9600213"
            )
            print("Got response:", response)
        } catch {
            print("Error fetching routes from station:", error)
        }
    }
}
