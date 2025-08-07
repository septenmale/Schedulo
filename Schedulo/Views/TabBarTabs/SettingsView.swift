//
//  SettingsView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 16/06/2025.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settingsVM: SettingsViewModel
        
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Toggle("Темная тема", isOn: $settingsVM.isDarkMode)
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
    @Previewable @State var settingsVM = SettingsViewModel()
    SettingsView(settingsVM: $settingsVM)
}
