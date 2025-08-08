//
//  StoriesPreview.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 09/07/2025.
//

import SwiftUI

struct StoriesPreview: View {
    let story: Stories
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.sImage)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .opacity(story.isShown ? 0.5 : 1.0)
            Text("Text Text Text Text Text Text Text Text Text")
                .lineLimit(3)
                .font(.system(size: 12, weight: .regular))
                .padding(8)
                .foregroundStyle(Color.appWhite)
        }
        .frame(width: 92, height: 140)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(story.isShown ? Color.clear : Color.appBlue, lineWidth: 4)
        )
    }
}

#Preview {
    let data = Stories(index: 3, sImage: "S-Story-1", lImage: "L-Story-1", isShown: false)
    StoriesPreview(story: data)
}
