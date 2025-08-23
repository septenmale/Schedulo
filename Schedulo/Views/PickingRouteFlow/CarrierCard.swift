//
//  CarrierCard.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 27/06/2025.
//

import SwiftUI

struct CarrierCard: View {
    @State private var vm = CarrierCardViewModel()
    let carrier: RouteDetailsModel
    
    var body: some View {
        VStack {
            Image(.rgdTitle)
            VStack(alignment: .leading, spacing: 16) {
                Text(vm.carrier?.name ?? "No name")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.appBlackDay)
                VStack(alignment: .leading, spacing: 4) {
                    Text("E-mail")
                        .font(.system(size: 16, weight: .regular))
                    Text(verbatim: vm.carrier?.email ?? "No email")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.appBlue)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("PhoneString")
                        .font(.system(size: 16, weight: .regular))
                    Text(verbatim: vm.carrier?.phone ?? "No phone")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.appBlue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            Spacer()
            
        }
        .task {
            await vm.getCarrierInfo(by: carrier.carrierCode)
        }
        .navigationTitle(Text("CarrierInformationString"))
        .toolbarRole(.editor)
    }
}

//#Preview {
//    let info =  CarrierCardInfo(name: "РЖД", date: "14 января", departureTime: "22:30", arrivalTime: "08:15", time: "20 часов", shouldTransfer: true)
//    CarrierCard(carrier: info)
//}
