//
//  StoriesFullscreenView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 24/07/2025.
//

import SwiftUI

struct StoriesFullscreenView: View {
    let index: Int
    let data: [StoriesData]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.appBlack.ignoresSafeArea()
            Image(data[index].lImage)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .overlay(
                    StoryTemplateView()
                )
                .padding(.init(top: 7, leading: 0, bottom: 17, trailing: 0))
            
            CloseButton{ dismiss() }
                .padding(.init(top: 57, leading: 0, bottom: 0, trailing: 12))
        }
    }
}

#Preview {
    let data = StoriesData(sImage: "S-Story-1", lImage: "L-Story-3", isShown: false)
    StoriesFullscreenView(index: 0, data: [data])
}
