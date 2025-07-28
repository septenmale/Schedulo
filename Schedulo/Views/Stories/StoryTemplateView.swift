//
//  StoryTemplateView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 25/07/2025.
//

import SwiftUI

struct StoryTemplateView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer()
            Text("Text Text Text Text Text Text Text Text Text Text")
                .font(.system(size: 34, weight: .bold))
                .lineLimit(2)
            Text("Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
                .font(.system(size: 20, weight: .regular))
                .lineLimit(3)
        }
        .foregroundStyle(.appWhite)
        .padding(.init(top: 0, leading: 16, bottom: 57, trailing: 16))
    }
}

#Preview {
    Color.purple
        .ignoresSafeArea()
        .overlay {
            StoryTemplateView()
        }
}
