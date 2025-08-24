//
//  StoriesPlaybackViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 08/08/2025.
//

import Foundation

@Observable
final class StoriesPlaybackViewModel {
    struct Configuration {
        let timerTickInterval: TimeInterval
        let progressPerTick: CGFloat
        
        init(
            secondsPerStory: TimeInterval = 5,
            timerTickInterval: TimeInterval = 0.05
        ) {
            self.timerTickInterval = timerTickInterval
            self.progressPerTick = 1.0 / secondsPerStory * timerTickInterval
        }
    }
    
    let storiesVM: StoriesViewModel
    var shouldDismiss: Bool = false
    var progress: CGFloat = 0
    var currentIndex: Int
    var currentStory: Stories { storiesVM.stories[currentIndex] }
    var progressBarOverallValue: CGFloat {
        // Например, если currentStoryIndex = 1, progress = 0.5, data.count = 5
        // То прогресс-бара = (1 + 0.5) / 5 = 0.3
        (CGFloat(currentIndex) + progress) / CGFloat(storiesVM.stories.count)
    }
    
    private let configuration: Configuration
    private var timer: Timer?
    
    init(
        storiesVM: StoriesViewModel,
        initialIndex: Int
    ) {
        self.storiesVM = storiesVM
        self.currentIndex = initialIndex
        self.configuration = Configuration()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func previousStory() {
        if currentIndex > 0 {
            currentIndex -= 1
        } else {
            
            shouldDismiss = true
        }
        progress = 0
    }
    
    func nextStory() {
        storiesVM.markStoryAsShown(at: currentIndex)
        
        if currentIndex < storiesVM.stories.count - 1 {
            currentIndex += 1
        } else {
            shouldDismiss = true
        }
        progress = 0
    }
    
    func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1.0 {
            nextProgress = 0
            nextStory()
        }
        progress = nextProgress
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: configuration.timerTickInterval, repeats: true) { [weak self] _ in
            self?.timerTick()
        }
    }
    
    func resetTimer() {
        stopTimer()
        progress = 0
        startTimer()
    }
}
