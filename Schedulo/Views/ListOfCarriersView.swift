//
//  CarriersView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 23/06/2025.
//

import SwiftUI

struct CarriersView: View {
    @Binding var fromHistory: SelectionHistory
    @Binding var toHistory: SelectionHistory
    
    //TODO: Убрать в ViewModel
    /// Моки для отображения списка перевозчиков
    let listOfCarriers: [CarrierCardInfo] = [
        CarrierCardInfo(name: "РЖД", date: "14 января", departureTime: "22:30", arrivalTime: "08:15", time: "20 часов", shouldTransfer: true),
        CarrierCardInfo(name: "ФГК", date: "15 января", departureTime: "01:15", arrivalTime: "09:00", time: "20 часов", shouldTransfer: false),
        CarrierCardInfo(name: "Урал логистика", date: "16 января", departureTime: "12:30", arrivalTime: "21:00", time: "9 часов", shouldTransfer: false),
        CarrierCardInfo(name: "РЖД", date: "17 января", departureTime: "22:30", arrivalTime: "08:15", time: "20 часов", shouldTransfer: true),
        CarrierCardInfo(name: "РЖД", date: "17 января", departureTime: "23:15", arrivalTime: "09:40", time: "20 часов", shouldTransfer: false)
    ]
    
    var body: some View {
        VStack() {
            Text("\(fromHistory.city ?? "") (\(fromHistory.station ?? "")) -> \(toHistory.city ?? "") (\(toHistory.station ?? ""))")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.appBlackDay)
                .padding()
            
        // Как я понял при нажатии на карточку переход на инфо о первозчике
            List(listOfCarriers) { card in
                CarrierCellView(carrierInfo: card)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .safeAreaInset(edge: .bottom) {
                Button {
                    // action
                } label: {
                    //TODO: изменить key
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color.appWhite)
                        .frame(width: 343, height: 60)
                        .background(Color.appBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                // describe navigational destination
            }
        }
        .padding()
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    @Previewable @State var fromHistory = SelectionHistory(role: .from, city: "Москва", station: "Ярославский вокзал")
    @Previewable @State var toHistory = SelectionHistory(role: .from, city: "Санкт Петербург", station: "Балтийский вокзал")
    CarriersView(fromHistory: $fromHistory, toHistory: $toHistory)
}
