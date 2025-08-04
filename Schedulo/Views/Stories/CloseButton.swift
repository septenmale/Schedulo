//
//  CloseButton.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 25/07/2025.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("", image: .closeStoryButton) {
            action()
        }
        .frame(width: 30, height: 30)
    }
}

#Preview {
    let action = { print("Action") }
    CloseButton(action: action)
}
