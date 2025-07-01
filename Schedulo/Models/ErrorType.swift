//
//  ErrorType.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 01/07/2025.
//

enum ErrorType {
    case noInternet
    case serverError
    
    var imageName: String {
        switch self {
        case .noInternet: "NoInternetError"
        case .serverError: "ServerError"
        }
    }
    
    var title: String {
        switch self {
            //TODO: Локализация
        case .noInternet: "Нет интернета"
        case .serverError: "Ошибка сервера"
        }
    }
}
