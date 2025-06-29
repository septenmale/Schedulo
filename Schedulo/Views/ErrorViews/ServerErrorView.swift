//
//  ServerErrorView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 29/06/2025.
//

import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        VStack {
            Image(.serverError)
            
            //TODO: локализация
            Text("ServerErrorTitle")
                .titleStyle()
        }
    }
}

#Preview {
    ServerErrorView()
}
