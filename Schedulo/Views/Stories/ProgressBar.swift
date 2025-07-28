//
//  ProgressBar.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 28/07/2025.
//

import SwiftUI

import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 6
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                       
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundColor(.appBlue)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

#Preview {
    Image(.lStory1)
        .resizable()
        .ignoresSafeArea()
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .overlay(
            ProgressBar(numberOfSections: 5, progress: 0.5)
                .padding()
        )
        .padding(.init(top: 7, leading: 0, bottom: 17, trailing: 0))

}
