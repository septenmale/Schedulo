//
//  ContentView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 29/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            testFetchRoutesFromStation()
        }
    }
}

#Preview {
    ContentView()
}

// мой ключ 3c35e80c-ee35-4151-9e13-348cf777ab10
