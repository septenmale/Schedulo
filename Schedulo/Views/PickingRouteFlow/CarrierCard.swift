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

//#Preview {
//    let info =  CarrierCardInfo(name: "РЖД", date: "14 января", departureTime: "22:30", arrivalTime: "08:15", time: "20 часов", shouldTransfer: true)
//    CarrierCard(carrier: info)
//}


//func loadStrings() async {
//    let loadTask = Task { () -> [String] in
//        let url = URL(string: "https://...")!
//        let (data, _) = try await URLSession.shared.data(from: url)
//        try Task.checkCancellation()
//        let strings = try JSONDecoder().decode([String].self, from: data)
//        // Обработка строк или их сохранение
//        return strings
//    }
//    do {
//        let result = try await loadTask.value
//    } catch {
//        // Обработка ошибки, включая отмену задачи
//    }
//}
//
//let mainTaskk = Task {
//   let task1 = Task {
//       // ...
//   }
//   let task2 = Task {
//       // ...
//   }
//
//   await withTaskCancellationHandler {
//       _ = await task1.result
//       _ = await task2.result
//   } onCancel: {
//       task1.cancel()
//       task2.cancel()
//   }
//    
//    mainTaskk.cancel()
//}
//
//
//
//let mainTask = Task {
//    await withTaskGroup(of: Void.self) { group in
//        group.addTask {
//            // ...
//        }
//        group.addTask {
//            // ...
//        }
//    }
//    mainTask.cancel()
//}
//
//let songs = await withTaskGroup(of: String.self, returning: [String].self) { group in
//    let albumsIDs = await albums(singer: "Frank Sinatra")
//    for album in albumsIDs {
//        group.addTask { await songs(in: album) }
//    }
//
//    let song = try await group.next()
//    return songs
//}
//
//final class Test: Sendable {
//    let age = 2
//}


