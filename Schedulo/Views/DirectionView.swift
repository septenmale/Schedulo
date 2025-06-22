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
            .offset(y: -120)
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
        }
    }
}

#Preview {
    ContentView()
}
