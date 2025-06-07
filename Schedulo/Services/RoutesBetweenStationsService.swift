//
//  RoutesBetweenStationsService.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 04/06/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias RoutesBetweenStations = Components.Schemas.Segments

protocol RoutesBetweenStationsServiceProtocol {
    func getRoutesBetweenStations(from: String, to: String) async throws -> RoutesBetweenStations
}

/// Service to receive a list of trips from the specified departure station to the specified arrival station, along with details for each trip.
final class RoutesBetweenStationsService: RoutesBetweenStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    ///  Perform request for list of trips between specified stations
    /// - Parameters:
    ///   - from:departure station
    ///   - to: arrival station
    ///   - date: date of a trip ( optional )
    /// - Returns: response in a JSON format
    func getRoutesBetweenStations(from: String, to: String) async throws -> RoutesBetweenStations {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
        ))
        
        return try response.ok.body.json
    }
}

/// Func for test call API request
func testFetchRoutesBetweenStations() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            //TODO: Заменить на enum appKeys.yandexRaspAPIKey.rawValue тут и дальше
            let service = RoutesBetweenStationsService(
                client: client,
                apikey: "3c35e80c-ee35-4151-9e13-348cf777ab10"
            )
            
            print("Fetching routes between stations...")
            let response = try await service.getRoutesBetweenStations(
                from: "s2000001",
                to: "s9605027",
            )
            print("Got response:", response)
        } catch {
            print("Error fetching routes between stations:", error)
        }
    }
}
