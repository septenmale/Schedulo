//
//  NoInternetView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 29/06/2025.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack {
            Image(.noInternetError)
            
            //TODO: локализация
            Text("NoInternetTitle")
                .titleStyle()
        }
    }
}

#Preview {
    NoInternetView()
}
