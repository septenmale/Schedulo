//
//  DirectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 15/06/2025.
//

import SwiftUI

struct DirectionView: View {
    //TODO: Возможно текст в кнопках стоит сделать State чтобы изменения оказывались в нем после флоу выбора станции.
    // Стоит так же создать структуру для передачи данных. Откуда/куда станция/город
    
    /// Описфывает возможные шаги моего флоу.
    /// стоит подправить добавив переменные на прием или создав отдельно для откуда куда.
    enum Route: Hashable {
        case selectCity
        case selectStation
    }
    
    /// Навигационный стек. Сюда буду добавлять экраны
    @State private var path: [Route] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.appBlue)
                    .frame(width: 343, height: 128)
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        NavigationLink(
                            destination: CitySelectionView(),
                            label: {
                            HStack {
                                // Text must be changed by station name after selection
                                Text("From")
                                    .foregroundStyle(Color.appGray)
                                    .font(.system(size: 17, weight: .regular))
                                Spacer()
                            }
                        })
                        Spacer()
                        //Передать выбранный город
                        NavigationLink(destination: CitySelectionView(), label: {
                            HStack {
                                // Text must be changed by station name after selection
                                Text("To") 
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
