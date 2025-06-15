//
//  ContentView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 29/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var fromToGo: String = ""
    @State private var whereToGo: String = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.appBlue)
                .frame(width: 343, height: 128)
            VStack(spacing: 0) {
                    TextField("", text: $fromToGo, prompt: Text("Откуда"))
                    .padding(.horizontal, 32)
                    .frame(height: 48)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    TextField("", text: $whereToGo, prompt: Text("Куда"))
                    .padding(.horizontal, 32)
                    .frame(height: 48)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}

#Preview {
    ContentView()
}
