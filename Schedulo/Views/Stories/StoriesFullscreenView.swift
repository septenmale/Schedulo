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
    
    var body: some View {
        Text("Current index: \(index)")
    }
}

#Preview {
    let data: [StoriesData] = [StoriesData(sImage: "S-Story-1", lImage: "L-Story-1", isShown: false)]
    StoriesFullscreenView(index: 2, data: data)
}
