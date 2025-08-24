//
//  FilterModels.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 13/08/2025.
//

enum DepartureTime: String, CaseIterable {
    //TODO: Разобрать с локализацией
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}

enum TransferFilter: String, CaseIterable {
    //TODO: Разобрать с локализацией
    case yes = "Да"
    case no = "Нет"
}

struct FilterState {
    var times: Set<DepartureTime>
    var transfer: TransferFilter?
}
