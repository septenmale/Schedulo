//
//  CarrierCardInfo.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 15/08/2025.
//

import Foundation

/// Описывает модель деталей маршрута
struct RouteDetailsModel: Hashable, Identifiable, Sendable {
    let id: String
    
    let name: String
    let carrierCode: String
    let logoURL: URL?
    
    //TODO: Убрать
    let fromTitle: String
    let toTitle: String
    
    let departureRaw: String
    let arrivalRaw: String
    let durationSeconds: Int
    let hasTransfers: Bool
}

extension RouteDetailsModel {
    // MARK: Парсинг исходных ISO-дат
    var departureDate: Date? { Self.parseISO(departureRaw) }
    var arrivalDate:   Date? { Self.parseISO(arrivalRaw) }
    
    // MARK: Готовые строки для UI
    var dateText: String {
        guard let d = departureDate else { return "" }
        return Self.date.string(from: d)       // "14 января"
    }
    
    var departureTimeText: String {
        guard let d = departureDate else { return "" }
        return Self.time.string(from: d)       // "22:30"
    }
    
    var arrivalTimeText: String {
        guard let a = arrivalDate else { return "" }
        return Self.time.string(from: a)       // "08:15"
    }
    
    var durationText: String {
        let total = max(0, durationSeconds)
        let h = total / 3600
        return "\(h) " + Self.plural(h, ["час","часа","часов"])
    }
    //убрать
    var transferSubtitle: String? {
        hasTransfers ? "С пересадкой" : nil
    }
    
    // MARK: форматтеры (кэшируем)
    private static let isoNoFrac: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withColonSeparatorInTimeZone]
        return f
    }()
    
    private static let isoWithFrac: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withColonSeparatorInTimeZone]
        return f
    }()
    
    /// Универсальный парсер ISO-дат: сначала пытается без долей секунды, затем с долями
    private static func parseISO(_ s: String) -> Date? {
        isoNoFrac.date(from: s) ?? isoWithFrac.date(from: s)
    }
    
    private static let date: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ru_RU")
        f.dateFormat = "d MMMM"
        return f
    }()
    
    private static let time: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ru_RU")
        f.dateFormat = "HH:mm"
        return f
    }()
    
    private static func plural(_ n: Int, _ forms: [String]) -> String {
        let n10 = n % 10, n100 = n % 100
        if n10 == 1 && n100 != 11 { return forms[0] }
        if (2...4).contains(n10) && !(12...14).contains(n100) { return forms[1] }
        return forms[2]
    }
}
