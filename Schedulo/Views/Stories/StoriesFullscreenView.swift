//
//  StoriesFullscreenView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 24/07/2025.
//

import SwiftUI

struct StoriesFullscreenView: View {
    //TODO: Возможно стоит обьявить в DirectionView как State и прокинуть сюда как Binding чтобы не создавать initialStoryIndex
    @State private var currentStoryIndex: Int = 0
    @State private var timer: Timer?
    @Environment(\.dismiss) private var dismiss
    
    let data: [StoriesData]
    let initialStoryIndex: Int
    var storyDuration: TimeInterval = 5
    
    /// computed property для расчета текущей истории к показу
    private var currentStory: StoriesData { data[currentStoryIndex] }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.appBlack.ignoresSafeArea()
            Image(currentStory.lImage)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .overlay(
                    StoryTemplateView()
                )
                .padding(.init(top: 7, leading: 0, bottom: 17, trailing: 0))
            
            CloseButton{ dismiss() }
                .padding(.init(top: 57, leading: 0, bottom: 0, trailing: 12))
        }
        .onAppear {
            currentStoryIndex = initialStoryIndex
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .onTapGesture {
            nextStory()
            resetTimer()
        }
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: storyDuration, repeats: true, block: { _ in
            nextStory()
        })
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func nextStory() {
        let nextStoryIndex = currentStoryIndex + 1
        if nextStoryIndex < data.count {
            currentStoryIndex = nextStoryIndex
        } else {
            currentStoryIndex = 0
        }
    }
    
    private func resetTimer() {
        stopTimer()
        startTimer()
    }
}

#Preview {
    let data = StoriesData(sImage: "S-Story-1", lImage: "L-Story-3", isShown: false)
    StoriesFullscreenView(data: [data], initialStoryIndex: 0)
}
