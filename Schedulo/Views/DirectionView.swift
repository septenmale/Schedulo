//
//  DirectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 15/06/2025.
//

import SwiftUI

struct DirectionView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.appBlue)
                    .frame(width: 343, height: 128)
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        NavigationLink(destination: CitySelectionView(), label: {
                            HStack {
                                // Text must be changed by station name after selection
                                Text("Откуда") // Локализация
                                    .foregroundStyle(Color.appGray)
                                    .font(.system(size: 17, weight: .regular))
                                Spacer()
                            }
                        })
                        Spacer()
                        NavigationLink(destination: CitySelectionView(), label: {
                            HStack {
                                // Text must be changed by station name after selection
                                Text("Куда") // Локализация
                                    .foregroundStyle(Color.appGray)
                                    .font(.system(size: 17, weight: .regular))
                                Spacer()
                            }
                        })
                    }
                    .padding()
                    .frame(width: 259, height: 96)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                    Spacer()
                    // Кнопка вместе картинки
                    Button {
                        // Reverse elements
                    } label: {
                        Image(.reverseButton)
                            .frame(width: 36, height: 36)
                    }
                }
                .padding()
                .frame(width: 343, height: 128)
                
            }
            .offset(y: -120)
        }
    }
}

#Preview {
    ContentView()
}
