//
//  DirectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 15/06/2025.
//

import SwiftUI

struct DirectionView: View {
    let stories: [StoriesData] = [
        StoriesData(sImage: "S-Story-1", lImage: "", isShown: false),
        StoriesData(sImage: "S-Story-2", lImage: "", isShown: false),
        StoriesData(sImage: "S-Story-3", lImage: "", isShown: false),
        StoriesData(sImage: "S-Story-4", lImage: "", isShown: false),
        StoriesData(sImage: "S-Story-5", lImage: "", isShown: false),
        StoriesData(sImage: "S-Story-6", lImage: "", isShown: true),
        StoriesData(sImage: "S-Story-7", lImage: "", isShown: false),
        StoriesData(sImage: "S-Story-8", lImage: "", isShown: false),
        StoriesData(sImage: "S-Story-9", lImage: "", isShown: false),
    ]
    
    @State private var path = NavigationPath()
    @State private var fromHistory = SelectionHistory(role: .from)
    @State private var toHistory = SelectionHistory(role: .to)
    @State private var showCarriers = false
    
    var shouldShowButton: Bool {
        fromHistory.station != nil && toHistory.station != nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // STORIES
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(stories) { story in
                        StoriesPreview(data: story)
                    }
                }
                .padding(16)
            }
            .frame(height: 144)
            .ignoresSafeArea(.all, edges: .trailing)
            
            // MAIN CARD
            NavigationStack(path: $path) {
                VStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.appBlue)
                            .frame(height: 128)
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Button {
                                    path.append(fromHistory)
                                } label: {
                                    HStack {
                                        Text(fromHistory.giveString())
                                            .foregroundStyle(fromHistory.city != nil ? Color.appBlack : Color.appGray)
                                            .font(.system(size: 17, weight: .regular))
                                        Spacer()
                                    }
                                }
                                Spacer()
                                Button {
                                    path.append(toHistory)
                                } label: {
                                    HStack {
                                        Text(toHistory.giveString())
                                            .foregroundStyle(fromHistory.city != nil ? Color.appBlack : Color.appGray)
                                            .font(.system(size: 17, weight: .regular))
                                        Spacer()
                                    }
                                }
                            }
                            .padding()
                            .frame(width: 259, height: 96)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                            )
                            Spacer()
                            Button {
                                let tempCity = fromHistory.city
                                let tempStation = fromHistory.station
                                
                                fromHistory.city = toHistory.city
                                fromHistory.station = toHistory.station
                                
                                toHistory.city = tempCity
                                toHistory.station = tempStation
                            } label: {
                                Image(.reverseButton)
                                    .frame(width: 36, height: 36)
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal, 16)
                    
                    .navigationDestination(for: SelectionHistory.self) { step in
                        if step.city == nil {
                            CitySelectionView(
                                path: $path,
                                selectionHistory: step.role == .from ? $fromHistory : $toHistory,
                            )
                        } else if step.station == nil {
                            StationSelectionView(
                                path: $path,
                                selectionHistory: step.role == .from ? $fromHistory : $toHistory
                            )
                        } else {
                            CitySelectionView(
                                path: $path,
                                selectionHistory: step.role == .from ? $fromHistory : $toHistory,
                            )
                        }
                    }
                    
                    if shouldShowButton {
                        NavigationLink {
                            CarriersView(routeInfo: RouteInfo(
                                fromCity: fromHistory.city ?? "",
                                toCity: toHistory.city ?? "",
                                fromStation: fromHistory.station ?? "",
                                toStation: toHistory.station ?? "")
                            )
                        } label: {
                            Text("SearchButton")
                                .frame(width: 150, height: 60)
                                .buttonStyle()
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            Spacer()
            Rectangle()
                .frame(height: 1)
                .padding(.top, 16)
        }
    }
}

#Preview {
    ContentView()
}
