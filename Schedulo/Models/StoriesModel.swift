//
//  StoriesModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 07/08/2025.
//

import Foundation

struct Stories: Identifiable {
    var id = UUID()
    let index: Int
    let sImage: String
    let lImage: String
    var isShown: Bool
}
