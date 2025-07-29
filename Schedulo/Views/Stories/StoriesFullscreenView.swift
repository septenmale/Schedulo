//
//  StoriesFullscreenView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 24/07/2025.
//

import SwiftUI

struct StoriesFullscreenView: View {
    struct Configuration {
        let timerTickInterval: TimeInterval
        let progressPerTick: CGFloat
        
        init(
            storiesCount: Int,
            secondsPerStory: TimeInterval = 5,
            timerTickInterval: TimeInterval = 0.05
        ) {
            self.timerTickInterval = timerTickInterval
            self.progressPerTick = 1.0 / secondsPerStory * timerTickInterval
        }
    }
    
    let data: [StoriesData]
    let initialStoryIndex: Int
    var markStoryAsShown: ((Int) -> Void)?
    let storyDuration: TimeInterval = 5
    
    @State private var currentStoryIndex: Int = 0
    @State private var progress: CGFloat = 0
    @State private var timer: Timer?
    @Environment(\.dismiss) private var dismiss
    
    private let configuration: Configuration
    private var currentStory: StoriesData { data[currentStoryIndex] }
    
    init(data: [StoriesData], initialStoryIndex: Int, markStoryAsShown: ((Int) -> Void)?) {
        self.data = data
        self.initialStoryIndex = initialStoryIndex
        self.markStoryAsShown = markStoryAsShown
        self.configuration = Configuration(storiesCount: data.count)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()
            Image(currentStory.lImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .overlay(StoryTemplateView())
                .padding(.init(top: 7, leading: 0, bottom: 17, trailing: 0))
            
            ProgressBar(numberOfSections: data.count, progress: progressBarOverallValue)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            CloseButton { dismiss() }
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .onAppear {
            currentStoryIndex = initialStoryIndex
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        //TODO: Добавить переключение по свайпу лево/право
        .onTapGesture {
            nextStory()
            resetTimer()
        }
    }
    
    /// Значение прогресс-бара для всего набора stories
    private var progressBarOverallValue: CGFloat {
        // Например, если currentStoryIndex = 1, progress = 0.5, data.count = 5
        // То прогресс-бара = (1 + 0.5) / 5 = 0.3
        (CGFloat(currentStoryIndex) + progress) / CGFloat(data.count)
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: configuration.timerTickInterval, repeats: true) { _ in
            timerTick()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func resetTimer() {
        stopTimer()
        progress = 0
        startTimer()
    }
    
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1.0 {
            // История закончилась — переход к следующей
            nextProgress = 0
            nextStory()
            markStoryAsShown?(currentStoryIndex - 1)
        }
        progress = nextProgress
    }
    
    private func nextStory() {
        if currentStoryIndex < data.count - 1 {
            currentStoryIndex += 1
        } else {
            // Последняя история — закрываем окно
            dismiss()
        }
        progress = 0
    }
}

#Preview {
    let data = StoriesData(sImage: "S-Story-1", lImage: "L-Story-3", isShown: false)
    StoriesFullscreenView(data: [data], initialStoryIndex: 0, markStoryAsShown: nil)
}
