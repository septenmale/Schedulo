//
//  StoriesFullscreenView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 24/07/2025.
//

import SwiftUI

struct StoriesFullscreenView: View {
    let initialStoryIndex: Int
    @Binding var storiesVM: StoriesViewModel
    
    @State private var playbackVM: StoriesPlaybackViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(
        storiesVM: Binding<StoriesViewModel>,
        initialStoryIndex: Int,
    ) {
        self._storiesVM = storiesVM
        self.initialStoryIndex = initialStoryIndex
        _playbackVM = State(initialValue: StoriesPlaybackViewModel(
            storiesVM: storiesVM.wrappedValue,
            initialIndex: initialStoryIndex
        ))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()
            Image(playbackVM.currentStory.lImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .overlay(StoryTemplateView())
                .padding(.init(top: 7, leading: 0, bottom: 17, trailing: 0))
            
            ProgressBar(
                numberOfSections: storiesVM.stories.count,
                progress: playbackVM.progressBarOverallValue
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            CloseButton { dismiss() }
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .onAppear {
            playbackVM.startTimer()
        }
        .onDisappear {
            playbackVM.stopTimer()
        }
        .onTapGesture {
            playbackVM.nextStory()
            playbackVM.resetTimer()
        }
        .onChange(of: playbackVM.shouldDismiss, { _, newValue in
            newValue ? dismiss() : ()
            playbackVM.shouldDismiss = false
        })
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -50 {
                        playbackVM.nextStory()
                    } else if value.translation.width > 50 {
                        playbackVM.previousStory()
                    } else if value.translation.height > 50 {
                        dismiss()
                    }
                }
        )
    }
}

#Preview {
    @Previewable @State var storiesVM = StoriesViewModel()
    StoriesFullscreenView(storiesVM: $storiesVM, initialStoryIndex: 0)
}
