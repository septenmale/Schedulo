//
//  ButtonStyleExtension.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 27/06/2025.
//

import SwiftUI

extension View {
    func buttonStyle() -> some View {
        self
            .font(.system(size: 17, weight: .bold))
            .foregroundStyle(Color.appWhite)
            .background(Color.appBlue)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
