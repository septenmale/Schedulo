//
//  StoriesViewModel.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 07/08/2025.
//

import Foundation

@Observable
final class StoriesViewModel {
    var stories: [Stories] = [
        Stories(index: 0, sImage: "S-Story-1", lImage: "L-Story-1", isShown: false),
        Stories(index: 1, sImage: "S-Story-2", lImage: "L-Story-2", isShown: false),
        Stories(index: 2, sImage: "S-Story-3", lImage: "L-Story-3", isShown: false),
        Stories(index: 3, sImage: "S-Story-4", lImage: "L-Story-4", isShown: false),
        Stories(index: 4, sImage: "S-Story-5", lImage: "L-Story-5", isShown: false),
        Stories(index: 5, sImage: "S-Story-6", lImage: "L-Story-6", isShown: false),
        Stories(index: 6, sImage: "S-Story-7", lImage: "L-Story-7", isShown: false),
        Stories(index: 7, sImage: "S-Story-8", lImage: "L-Story-8", isShown: false),
        Stories(index: 8, sImage: "S-Story-9", lImage: "L-Story-9", isShown: false),
    ]
    
    func markStoryAsShown(at index: Int) {
        stories[index].isShown = true
    }
}
