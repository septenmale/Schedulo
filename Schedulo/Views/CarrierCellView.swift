//
//  CarrierCellView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 24/06/2025.
//

import SwiftUI

struct CarrierCellView: View {
    let carrierInfo: RouteDetailsModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.appLightGray)
                .frame(width: 343, height: 104)
            VStack {
                HStack {
                    logoView
                        .frame(width: 38, height: 38)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    VStack(alignment: .leading) {
                        Text(carrierInfo.name)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(Color.appBlack)
                        if carrierInfo.hasTransfers {
                            Text("С пересадкой")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.appRed)
                        }
                    }
                    Spacer()
                    Text(carrierInfo.dateText)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                }
                .padding([.top, .leading], 14)
                .padding(.trailing, 7)
                HStack {
                    Text(carrierInfo.departureTimeText)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(Color.appGray)
                    Text(carrierInfo.durationText)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(Color.appGray)
                    Text(carrierInfo.arrivalTimeText)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                }
                .padding()
            }
        }
        //TODO: Разобраться с этим. Возможно фикс ширина не лучший вывод, полагаться больше на .padding(.horizontal, 16)
        .frame(width: 343, height: 104)
    }
    
    @ViewBuilder
    private var logoView: some View {
        if let url = carrierInfo.logoURL {
            AsyncImage(url: url, transaction: .init(animation: .default)) { phase in
                switch phase {
                case .empty:
                    ProgressView().scaleEffect(0.8)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .background(Color.white.opacity(0.9))
                case .failure:
                    Image(.rgdCarrierIcon)
                        .resizable()
                        .scaledToFit()
                        .opacity(0.8)
                @unknown default:
                    Image(.rgdCarrierIcon)
                        .resizable()
                        .scaledToFit()
                        .opacity(0.8)
                }
            }
        } else {
            Image(.rgdCarrierIcon)
                .resizable()
                .scaledToFit()
                .opacity(0.8)
        }
    }
}

//#Preview {
//    let info = CarrierCardInfoNew(id: <#T##String#>, name: <#T##String#>, carrierCode: <#T##String#>, fromTitle: <#T##String#>, toTitle: <#T##String#>, departureRaw: <#T##String#>, arrivalRaw: <#T##String#>, durationSeconds: <#T##Int#>, hasTransfers: <#T##Bool#>)
//    CarrierCellView(carrierInfo: info)
//}
