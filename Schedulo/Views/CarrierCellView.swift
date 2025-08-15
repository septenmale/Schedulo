//
//  CarrierCellView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 24/06/2025.
//

import SwiftUI

struct CarrierCellView: View {
    let carrierInfo: CarrierCardInfo
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.appLightGray)
                .frame(width: 343, height: 104)
            VStack {
                HStack {
                    Image(.rgdCarrierIcon)
                        .frame(width: 38, height: 38)
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
        //TODO: Разобраться с этим. Возможно фикс ширина не лучший вывод, полагаться больше на .padding(.horizontal, 16)
        .frame(width: 343, height: 104)
    }
}

#Preview {
    let info = CarrierCardInfo(name: "РЖД", date: "14 января", departureTime: "22:30", arrivalTime: "08:15", time: "20 часов", shouldTransfer: false)
    CarrierCellView(carrierInfo: info)
}
