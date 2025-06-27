//
//  RouteFiltrationView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 27/06/2025.
//

import SwiftUI


//TODO: Убрать из View
enum DepartureTime: String, CaseIterable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}

//TODO: Убрать из View
enum TransferFilter: String, CaseIterable {
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
    
    //TODO: Найти способ хранить состоянии кнопки, менять изображение. Если все выбрано показать кнопку
    var body: some View {
        VStack(alignment: .leading) {
            Text("Время отправления")
            //TODO: Вынести настройку заголовка в Extension
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.appBlackDay)
                .padding()
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
                        Image(systemName: selectedDepartureTime.contains(time) ?
                              //TODO: Изменить картинки
                              "checkmark.square" : "square")
                        .font(.system(size: 24))
                    }
                }
            }
            .padding()
            Text("Показывать варианты с пересадками")
            //TODO: Вынести настройку заголовка в Extension
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.appBlackDay)
                .padding()
            ForEach(TransferFilter.allCases, id: \.self) { option in
                HStack {
                    Text(option.rawValue)
                    Spacer()
                    Button {
                        selectedTransferFilter = option
                    } label: {
                        Image(systemName: selectedTransferFilter == option ?
                              //TODO: Изменить картинки
                              "checkmark.circle" : "circle")
                        .font(.system(size: 24))
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
                //TODO: изменить key
                Text("Уточнить время")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color.appWhite)
                    .frame(width: 343, height: 60)
                    .background(Color.appBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding()
        }
    }
}

#Preview {
    let info = RouteInfo(fromCity: "Москва", toCity: "Санкт Петербург", fromStation: "Ярославский вокзал", toStation: "Балтийский вокзал")
    RouteFiltrationView(routeInfo: info)
}
