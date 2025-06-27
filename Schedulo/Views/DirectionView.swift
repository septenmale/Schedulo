//
//  DirectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 15/06/2025.
//

import SwiftUI

struct DirectionView: View {
    
    /// массив в котором хранятся значения какой экран показывать
    @State private var path = NavigationPath()
    
    /// Переменная для хранения истории выборов для "Откуда" флоу
    @State private var fromHistory = SelectionHistory(role: .from)
    
    /// Переменная для хранения истории выборов для "Куда" флоу
    @State private var toHistory = SelectionHistory(role: .to)
    @State private var showCarriers = false
    
    var shouldShowButton: Bool {
        fromHistory.city != nil && toHistory.city != nil
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.appBlue)
                        .frame(width: 343, height: 128)
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Button {
                                path.append(fromHistory)
                            } label: {
                                HStack {
                                    Text(fromHistory.giveString())
                                        .foregroundStyle(fromHistory.city != nil ? Color.appBlack : Color.appGray)
                                        .font(.system(size: 17, weight: .regular))
                                    Spacer()
                                }
                            }
                            Spacer()
                            Button {
                                path.append(toHistory)
                            } label: {
                                HStack {
                                    Text(toHistory.giveString())
                                        .foregroundStyle(toHistory.city != nil ? Color.appBlack : Color.appGray)
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
                        //TODO: Что то не так с кнопкой не дает вводить после свапа
                        Button {
                            let x = fromHistory
                            fromHistory = toHistory
                            toHistory = x
                        } label: {
                            Image(.reverseButton)
                                .frame(width: 36, height: 36)
                        }
                    }
                    .padding()
                    .frame(width: 343, height: 128)
                }
                .navigationDestination(for: SelectionHistory.self) { step in
                    if step.city == nil {
                        CitySelectionView(
                            path: $path,
                            selectionHistory: step.role == .from ? $fromHistory : $toHistory,
                        )
                    }
                    else {
                        StationSelectionView(
                            path: $path,
                            selectionHistory: step.role == .from ? $fromHistory : $toHistory
                        )
                    }
                }
                if shouldShowButton {
                    
                    // Тут через NavLink Описываю переход на след экран CarriersView
                    // Туда передаю данные через RouteInfo
                    //TODO: Разобраться с nil
                    NavigationLink {
                        CarriersView(routeInfo: RouteInfo(
                            fromCity: fromHistory.city ?? "",
                            toCity: toHistory.city ?? "",
                            fromStation: fromHistory.station ?? "",
                            toStation: toHistory.station ?? "")
                        )
                    } label: {
                        Text("Найти") // изменить key чтобы не было конфликтов
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color.appWhite)
                            .frame(width: 150, height: 60)
                            .background(Color.appBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
            .offset(y: -120)
        }
    }
}

#Preview {
    ContentView()
}
