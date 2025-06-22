//
//  SelectionHistory.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 22/06/2025.
//

//TODO: Переписать док-ю.
//TODO: На данный момент у меня есть и перечисление(для вью) и поле isFrom(для передачи между вью). Подумать как совместить
enum DirectionRole: String {
    case from = "From"
    case to = "To"
}

/// Хранит историю выбора местности. Используется так же как тип данных для навигации
struct SelectionHistory: Hashable {
    // Поменять isFrom на поле с типом перечисления
    var role: DirectionRole? = nil
    var isFrom: Bool? = nil
    var city: String? = nil
    var station: String? = nil
    
    /// Форматирует данные для отображения на главном экране
    /// - Parameter isFrom: "Откуда" или  "Куда"
    /// - Returns: Строка для отображения результата выбора
    func giveString() -> String {
        
        guard let city = city,
              let station = station else { return role!.rawValue }
        
        return "\(city)(\(station))"
    }
}
