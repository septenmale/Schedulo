//
//  CitySelectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 12/08/2025.
//

import Foundation
import OpenAPIURLSession

@MainActor
@Observable
final class CitySelectionViewModel {
    var isLoading: Bool = true
    
    private var payload: AllStations?
    private var desiredCountries = ["Россия", "Украина", "Польша"]
    var swiftCities: [City] = []
    
    var searchText = ""
    
    var searchResults: [City] {
        searchText.isEmpty ? swiftCities : swiftCities.filter { $0.title.localizedCaseInsensitiveContains(searchText.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    
    //TODO: Показыает фолс если сделать пару пробелов, но если начать вписывать то поведение ожидаемое
    var shouldShowNoResults: Bool {
        searchResults.isEmpty && isLoading == false
    }
    
    /// Сохраняет сырой payload и строит массив городов на основании него и выбранных стран
    func fetchCities() async {
        do {
            async let allStations = fetchAllStations()
            let payload = try await allStations
            isLoading = false
            self.payload = payload
            let cities = makeCities(from: payload, onlyCountries: desiredCountries)
            self.swiftCities = cities
        } catch {
            assertionFailure("Ошибка при загрузке городов: \(error.localizedDescription)")
        }
    }
    
    /// Фильтрует и достает станции по городу
    /// - Parameter cityCode: код города в системе кодирования yandex.rasp
    /// - Returns: Возвращает массив станций
    func stations(for cityCode: String) -> [Station] {
        guard let payload else { return [] }
        var out: [Station] = []
        
        for country in payload.countries ?? [] {
            for region in country.regions ?? [] {
                for s in region.settlements ?? [] {
                    let code = s.codes?.yandex_code
                    ?? [country.title, s.title].compactMap { $0 }.joined(separator: "|")
                    if code == cityCode {
                        for st in s.stations ?? [] {
                            if let title = st.title {
                                let stCode = st.codes?.yandex_code ?? "\(code)|\(title)"
                                out.append(Station(code: stCode, title: title))
                            }
                        }
                        return out.sorted { $0.title.localizedCompare($1.title) == .orderedAscending }
                    }
                }
            }
        }
        return []
    }
}

/// Фильтрует payload станций по странам
/// - Parameters:
///   - payload: сырые данные полученные из метода fetchAllStations
///   - onlyCountries: находим города только для этих стран
/// - Returns: преобразуем payload в удобную модель City
private func makeCities(from payload: AllStations,
                        onlyCountries: [String]?) -> [City] {
    var out: [City] = []
    for country in payload.countries ?? [] {
        let countryTitle = country.title?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let only = onlyCountries, let ct = countryTitle, !only.contains(ct) { continue }
        for region in country.regions ?? [] {
            for s in region.settlements ?? [] {
                guard let name = s.title?.trimmingCharacters(in: .whitespacesAndNewlines),
                      !name.isEmpty else { continue }
                let code = s.codes?.yandex_code
                ?? [countryTitle, name].compactMap { $0 }.joined(separator: "|")
                out.append(City(code: code, title: name, county: countryTitle))
            }
        }
    }
    
    var seen = Set<String>()
    let unique = out.filter { seen.insert($0.code).inserted }
    return unique.sorted { $0.title.localizedCompare($1.title) == .orderedAscending }
}

/// Делаем запрос через ListOfAvailableStationsService для получения всеъ станций
/// - Returns: Получаем список всех доступных станций типа AllStations
private func fetchAllStations() async throws -> AllStations {
    let client = Client(
        serverURL: try Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = ListOfAvailableStationsService(
        client: client,
        apikey: appKeys.yandexRaspAPIKey.rawValue
    )
    
    let response = try await service.getListOfAvailableStations()
    return response
}
