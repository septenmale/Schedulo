//
//  NearestStationsService.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 03/06/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

// Псевдоним для типа Stations чтобы не обращаться по полному имени
typealias NearestStations = Components.Schemas.Stations

/// Протокол для сервиса. В будущем облегчит тестирование
protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

final class NearestStationsService: NearestStationsServiceProtocol {
    /// Экземпляр сгенерированного клиента
    private let client: Client
    /// Хранит ключ. Т.к. лучше передавать его извне, чем хранить в сервисе
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        // вызываем функцию getNearestStations на экземпляре сгенерированного клиента.
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,     // передаем API-ключ
            lat: lat,           // Передаём широту
            lng: lng,           // Передаём долготу
            distance: distance  // Передаём дистанцию
        ))
        
        // response.ok: Доступ к успешному ответу
        // .body: Получаем тело ответа
        // .json: Получаем объект из JSON в ожидаемом типе NearestStations
        return try response.ok.body.json
    }
}

// Функция для тестового вызова API
func testFetchStations() {
    // Создаём Task для выполнения асинхронного кода
    Task {
        do {
            // 1. Создаём экземпляр сгенерированного клиента
            let client = Client(
                // Используем URL сервера, также сгенерированный из openapi.yaml (если он там определён)
                serverURL: try Servers.Server1.url(),
                // Указываем, какой транспорт использовать для отправки запросов
                transport: URLSessionTransport()
            )
            
            // 2. Создаём экземпляр нашего сервиса, передавая ему клиент и API-ключ
            let service = NearestStationsService(
                client: client,
                apikey: "3c35e80c-ee35-4151-9e13-348cf777ab10"
            )
            
            // 3. Вызываем метод сервиса
            print("Fetching stations...")
            let stations = try await service.getNearestStations(
                lat: 51.107883, // Пример координат
                lng: 17.038538, // Пример координат
                distance: 50    // Пример дистанции
            )
            
            // 4. Если всё успешно, печатаем результат в консоль
            print("Successfully fetched stations: \(stations)")
        } catch {
            // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
            //    она будет поймана здесь, и мы выведем её в консоль
            print("Error fetching stations: \(error)")
            // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
        }
    }
}
