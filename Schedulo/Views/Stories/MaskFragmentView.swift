//
//  MaskFragmentView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 28/07/2025.
//

import SwiftUI

struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: 6)
            .foregroundStyle(.appWhite)
    }
}

#Preview {
    ZStack {
        Color.blue.ignoresSafeArea()
        MaskFragmentView()
    }
    
}
