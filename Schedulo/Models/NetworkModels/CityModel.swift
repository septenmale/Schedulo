//
//  CityModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 18/08/2025.
//

struct City: Sendable {
    let code: String
    let title: String
    /// Не уверен что нужно здесь, но вероятно для фильтрации ответа по нужным странам
    // TODO: Все таки не надо, убрать
    let county: String?
}
