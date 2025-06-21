//
//  DirectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 15/06/2025.
//

import SwiftUI

enum Route: Hashable {
    case citySelection(isFrom: Bool)
    case stationSelection(isFrom: Bool, city: String)
}

// Стоит так же создать структуру для передачи данных. Откуда/куда станция/город

struct DirectionView: View {
    // Возможно текст в кнопках стоит сделать State чтобы изменения оказывались в нем после флоу выбора станции.
    
    /// массив в котором хранятся значения какой экран показывать
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.appBlue)
                    .frame(width: 343, height: 128)
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Button {
                            path.append(Route.citySelection(isFrom: true))
                        } label: {
                            HStack {
                                // Text must be changed by station name after selection
                                Text("From")
                                    .foregroundStyle(Color.appGray)
                                    .font(.system(size: 17, weight: .regular))
                                Spacer()
                            }
                        }
                        Spacer()
                        //Передать выбранный город
                        Button {
                            path.append(Route.citySelection(isFrom: false))
                        } label: {
                            HStack {
                                // Text must be changed by station name after selection
                                Text("To")
                                    .foregroundStyle(Color.appGray)
                                    .font(.system(size: 17, weight: .regular))
                                Spacer()
                            }
                        }
                        
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
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .citySelection(let isFrom):
                    CitySelectionView(path: $path, isFrom: isFrom)
                case .stationSelection(let isFrom, let city):
                    StationSelectionView(city: city, isFrom: isFrom, path: $path)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
