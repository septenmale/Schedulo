//
//  CarrierCardInfo.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 15/08/2025.
//

import Foundation

/// Описывает модель карточки перевозчика
struct CarrierCardInfo: Hashable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var date: String
    var departureTime: String
    var arrivalTime: String
    var time: String // Придумать как посчитать разницу
    var shouldTransfer: Bool
}
