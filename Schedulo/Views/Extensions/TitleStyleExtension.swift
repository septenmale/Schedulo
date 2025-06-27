//
//  TitleStyleExtension.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 27/06/2025.
//

import SwiftUI

extension View {
    func titleStyle() -> some View {
        self
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.appBlackDay)
            .padding()
    }
}
