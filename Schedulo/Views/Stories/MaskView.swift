//
//  ProgressBar.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 28/07/2025.
//

import SwiftUI

struct MaskView: View {
    let numberOfSections: Int

    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

#Preview {
    Color.blue
        .ignoresSafeArea()
        .overlay(
            MaskView(numberOfSections: 5)
                .padding()
        )
}
