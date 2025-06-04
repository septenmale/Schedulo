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
    func getRoutesBetweenStations(from: String, to: String, date: String?) async throws -> RoutesBetweenStations
}

final class RoutesBetweenStationsService: RoutesBetweenStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRoutesBetweenStations(from: String, to: String, date: String?) async throws -> RoutesBetweenStations {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date
        ))
        
        return try response.ok.body.json
    }
}

func testFetchRoutesBetweenStations() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = RoutesBetweenStationsService(
                client: client,
                apikey: "3c35e80c-ee35-4151-9e13-348cf777ab10"
            )
            
            print("Fetching routes between stations...")
            let response = try await service.getRoutesBetweenStations(
                from: "s2000001",
                to: "s9602496",
                date: "2025-06-06"
            )
            print("Got response:", response)
        } catch {
            print("Error fetching routes between stations:", error)
        }
    }
}
