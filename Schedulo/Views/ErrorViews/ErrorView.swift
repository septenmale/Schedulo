//
//  ErrorView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 01/07/2025.
//

import SwiftUI

struct ErrorView: View {
    let imageName: String
    let title: String
    
    
    var body: some View {
        VStack {
            Image(imageName)
            Text(title)
                .titleStyle()
        }
    }
}

#Preview {
    let imageName = "NoInternetError"
    let title = "No internet"
    ErrorView(imageName: imageName, title: title)
}
