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
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.appBlue)
                    .frame(width: 343, height: 128)
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Button {
                            path.append(SelectionHistory(role: .from, isFrom: true))
                            fromHistory.isFrom = true
                        } label: {
                            HStack {
                                if fromHistory.city != nil {
                                    Text(fromHistory.giveString())
                                        .foregroundStyle(Color.appBlack)
                                        .font(.system(size: 17, weight: .regular))
                                } else {
                                    // можно сократить оставив лишь один модификатор для шрифта меняя значение через colescing
                                    Text(fromHistory.giveString())
                                        .foregroundStyle(Color.appGray)
                                        .font(.system(size: 17, weight: .regular))
                                }
                                Spacer()
                            }
                        }
                        Spacer()
                        Button {
                            path.append(SelectionHistory(role: .to, isFrom: false))
                            fromHistory.isFrom = false
                        } label: {
                            HStack {
                                if toHistory.city != nil {
                                    Text(toHistory.giveString())
                                        .foregroundStyle(Color.appBlack)
                                        .font(.system(size: 17, weight: .regular))
                                } else {
                                    Text(toHistory.giveString())
                                        .foregroundStyle(Color.appGray)
                                        .font(.system(size: 17, weight: .regular))
                                }
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
                    Button {
                        // Reverse elements
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
            .offset(y: -120)
            .navigationDestination(for: SelectionHistory.self) { step in
                //TODO: Убрать форсы
                if step.city == nil {
                    CitySelectionView(
                        path: $path,
                        // достаточно будет прокидывать только role (step.role == .from ?)
                        selectionHistory: step.isFrom! ? $fromHistory : $toHistory,
                        isFrom: step.isFrom!
                    )
                }
                else {
                    StationSelectionView(
                        city: step.city!,
                        isFrom: step.isFrom!,
                        path: $path,
                        selectionHistory: step.isFrom! ? $fromHistory : $toHistory
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
