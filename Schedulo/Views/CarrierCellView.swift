//
//  CarrierCellView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 24/06/2025.
//

import SwiftUI

//TODO: Убрать в Models

/// Описывает модель карточки перевозчика
struct CarrierCardInfo: Hashable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var date: String
    var departureTime: String
    var arrivalTime: String
    var time: String // Придумать как посчитать разницу
    var shouldTransfer: Bool
}

struct CarrierCellView: View {
    let carrierInfo: CarrierCardInfo
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.appLightGray)
                .frame(width: 343, height: 104)
            
            // Самый главный, который соединит верхнюю и нижнюю половины
            VStack {
                
                // Отвечает за верхнюю половину
                HStack(alignment: .center) {
                    Image(.rgdCarrierIcon)
                        .frame(width: 38, height: 38)
                    
                    // VStack название пересадка(скрыть, если нету)
                    VStack(alignment: .leading) {
                        Text(carrierInfo.name)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(Color.appBlack)
                        if carrierInfo.shouldTransfer {
                            Text("С пересадкой в Костроме")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.appRed)
                        }
                    }
                    Spacer()
                    Text(carrierInfo.date)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                }
                .padding([.top, .leading], 14)
                .padding(.trailing, 7)
                
                // Отвечает за нижнюю половину
                HStack {
                    Text(carrierInfo.departureTime)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(Color.appGray)
                    Text(carrierInfo.time)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(Color.appGray)
                    Text(carrierInfo.arrivalTime)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                }
                .padding()
            }
        }
        .frame(width: 343, height: 104)
    }
}

#Preview {
    let info = CarrierCardInfo(name: "РЖД", date: "14 января", departureTime: "22:30", arrivalTime: "08:15", time: "20 часов", shouldTransfer: false)
    CarrierCellView(carrierInfo: info)
}
