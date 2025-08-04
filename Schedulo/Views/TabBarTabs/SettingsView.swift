//
//  SettingsView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 16/06/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("appearance") private var selectedAppearance: Appearance = .system
    @State private var isDarkThemeEnabled = false
    
    private var isDarkThemeBinding: Binding<Bool> {
        Binding(
            // при отрисовке показывает включенным если выполняется проверка
            get: { selectedAppearance == .dark },
            // когда значение меняется изменяет тему на темную, если включенный и наоборот
            set: { newValue in
                selectedAppearance = newValue ? .dark : .light
            }
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Toggle("Темная тема", isOn: isDarkThemeBinding)
                        .padding(.bottom)
                    NavigationLink {
                        UserAgreementView()
                    } label: {
                        HStack {
                            Text("Пользовательское соглашение")
                            Spacer()
                            Image(.chevronIcon)
                        }
                    }
                }
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.appBlackDay)
                .padding(.init(top: 24, leading: 16, bottom: 0, trailing: 16))
                
                Spacer()
                
                VStack(spacing: 24) {
                    VStack(spacing: 16 ) {
                        Text("Приложение использует API «Яндекс.Расписания»")
                        Text("Версия 1.0 (beta)")
                    }
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.appBlackDay)
                    
                    Rectangle()
                        .frame(height: 1)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
