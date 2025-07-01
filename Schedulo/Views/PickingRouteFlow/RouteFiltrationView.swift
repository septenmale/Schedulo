//
//  RouteFiltrationView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 27/06/2025.
//

import SwiftUI


//TODO: Убрать из View
enum DepartureTime: String, CaseIterable {
    //TODO: Разобрать с локализацией
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}

//TODO: Убрать из View
enum TransferFilter: String, CaseIterable {
    //TODO: Разобрать с локализацией
    case yes = "Да"
    case no = "Нет"
}

//TODO: Убрать из View
struct FilterState {
    var times: Set<DepartureTime>
    var transfer: TransferFilter
}

//TODO: Добавить локализацию
//TODO: Не много ли паддингов? Если вложенные вью нельзя ли сократить ?
struct RouteFiltrationView: View {
    @State private var selectedDepartureTime: Set<DepartureTime> = []
    @State private var selectedTransferFilter: TransferFilter? = nil
    
    /// Передает инфо о маршруте. Откуда/куда, город/станция
    var routeInfo: RouteInfo
    
    private var shouldShowButton: Bool {
        return !selectedDepartureTime.isEmpty && selectedTransferFilter != nil
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("DepartureTimeTitle")
                .titleStyle()
            ForEach(DepartureTime.allCases, id: \.self) { time in
                HStack {
                    Text(time.rawValue)
                    Spacer()
                    Button {
                        if selectedDepartureTime.contains(time) {
                            selectedDepartureTime.remove(time)
                        } else {
                            selectedDepartureTime.insert(time)
                        }
                    } label: {
                        Image(selectedDepartureTime.contains(time) ? .squareCheckmark : .square)
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .padding()
            Text("ShowTransferOptionsTitle")
                .titleStyle()
            ForEach(TransferFilter.allCases, id: \.self) { option in
                HStack {
                    Text(option.rawValue)
                    Spacer()
                    Button {
                        selectedTransferFilter = option
                    } label: {
                        Image(selectedTransferFilter == option ? .circleCheckmark : .circle)
                            .frame(width: 24, height: 24)
                    }
                    
                }
            }
            .padding()
            Spacer()
        }
        .padding()
        .toolbarRole(.editor)
        if shouldShowButton {
            NavigationLink {
                RouteDetailsView(
                    filter: FilterState(times: selectedDepartureTime, transfer: selectedTransferFilter ?? .yes),
                    routeInfo: routeInfo
                )
            } label: {
                Text("ApplyButtonTitle")
                    .frame(width: 343, height: 60)
                    .buttonStyle()
            }
            .padding()
        }
    }
}

#Preview {
    let info = RouteInfo(fromCity: "Москва", toCity: "Санкт Петербург", fromStation: "Ярославский вокзал", toStation: "Балтийский вокзал")
    RouteFiltrationView(routeInfo: info)
}
