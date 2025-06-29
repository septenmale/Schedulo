//
//  SelectionHistory.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 22/06/2025.
//

/// Перечисление для контроля выбора направления
enum DirectionRole: String {
    //TODO: Разобраться с локализацией
    case from = "Откуда"
    case to = "Куда"
}

/// Хранит историю выбора станции. Используется так же как тип данных для навигации
struct SelectionHistory: Hashable {
    let role: DirectionRole
    var city: String? = nil
    var station: String? = nil
    
    /// Форматирует данные для отображения на главном экране
    /// - Returns: Строка для отображения результата выбора
    func giveString() -> String {
        
        guard let city = city,
              let station = station else { return role.rawValue }
        
        return "\(city)(\(station))"
    }
}
