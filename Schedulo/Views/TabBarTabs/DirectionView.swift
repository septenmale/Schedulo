//
//  DirectionView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 15/06/2025.
//

import SwiftUI
//TODO: Я уже создал одну общую VM для управление назначениями и подвязал к ней экраны.
// далее остается подправить нав токен (по желанию), создать VM для станции/города и добавить VM для остальных экранов.
struct DirectionView: View {
    @State private var storiesVM = StoriesViewModel()
    @State private var directionVM = DirectionViewModel()
    @State private var path = NavigationPath()
    
    
    @State private var showCarriers = false
    @State private var selectedStory: Stories? = nil
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // STORIES
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(storiesVM.stories) { story in
                        StoriesPreview(story: story)
                            .onTapGesture {
                                selectedStory = story
                            }
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
                                Button { path.append(directionVM.from) } label: {
                                    HStack {
                                        Text(directionVM.from.giveString())
                                            .foregroundStyle(directionVM.from.city != nil ? Color.appBlack : Color.appGray)
                                            .font(.system(size: 17, weight: .regular))
                                        Spacer()
                                    }
                                }
                                Spacer()
                                Button { path.append(directionVM.to) } label: {
                                    HStack {
                                        Text(directionVM.to.giveString())
                                            .foregroundStyle(directionVM.to.city != nil ? Color.appBlack : Color.appGray)
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
                            Button { directionVM.swapDirections() } label: {
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
                                directionVM: $directionVM,
                                role: step.role,
                            )
                        } else if step.station == nil {
                            StationSelectionView(
                                directionVM: $directionVM,
                                path: $path,
                                role: step.role
                            )
                        } else {
                            CitySelectionView(
                                path: $path,
                                directionVM: $directionVM,
                                role: step.role
                            )
                        }
                    }
                    
                    if directionVM.shouldShowSearchButton {
                        NavigationLink {
                            CarriersView(routeInfo: directionVM.buildRouteInfo())
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
        
        .fullScreenCover(item: $selectedStory) { story in
            StoriesFullscreenView(
                storiesVM: $storiesVM,
                initialStoryIndex: story.index,
            )
        }
    }
}

#Preview {
    DirectionView()
}
