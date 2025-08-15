//
//  CarrierCard.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 27/06/2025.
//

import SwiftUI

struct CarrierCard: View {
    //TODO: Убрать опционал не забыть!
    let carrier: CarrierCardInfo?
    
    var body: some View {
        VStack {
            Image(.rgdTitle)
            VStack(alignment: .leading, spacing: 16) {
                Text("ОАО \"РЖД\"")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.appBlackDay)
                VStack(alignment: .leading, spacing: 4) {
                    Text("E-mail")
                        .font(.system(size: 16, weight: .regular))
                    Text(verbatim: "i.lozgkina@yandex.ru")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.appBlue)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("PhoneString")
                        .font(.system(size: 16, weight: .regular))
                    Text(verbatim: "+7 (904) 329-27-71")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.appBlue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            Spacer()
        }
        .navigationTitle(Text("CarrierInformationString"))
        .toolbarRole(.editor)
    }
}

#Preview {
    let info =  CarrierCardInfo(name: "РЖД", date: "14 января", departureTime: "22:30", arrivalTime: "08:15", time: "20 часов", shouldTransfer: true)
    CarrierCard(carrier: info)
}
