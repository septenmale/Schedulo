//
//  CarrierCardViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 23/08/2025.
//

import Foundation
import OpenAPIURLSession

@MainActor
@Observable
final class CarrierCardViewModel {
    private(set) var carrier: CarrierCardModel?
    
    func getCarrierInfo(by code: String) async {
        do {
            let carrierInfo = try await fetchCarrierInfo(by: code)
            carrier = carrierInfo
            print("Loaded carrierInfo: \(String(describing: carrier))")
        } catch {
            assertionFailure("Error loading carrierInfo: \(error.localizedDescription)")
        }
    }
    
    private func mapToCarrierCardModel(_ response: CarrierInfo) -> CarrierCardModel? {
        guard let carrier = response.carrier else { return nil }
        
        let name = carrier.title ?? "ОАО «РЖД»"
        let email = carrier.email ?? "i.lozgkina@yandex.ru"
        let phone = carrier.phone
        
        return CarrierCardModel(name: name, email: email, phone: phone)
    }
    
    private func fetchCarrierInfo(by code: String) async throws -> CarrierCardModel? {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = CarrierInfoService(
            client: client,
            apikey: appKeys.yandexRaspAPIKey.rawValue
        )
        
        let response = try await service.getCarrierInfo(by: code)
        return mapToCarrierCardModel(response)
    }
}
