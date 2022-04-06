//
//  StoriesViewModel.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 11/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa

enum StoryCellType {
    case normal(stories: StoryGroup)
}

class StoriesViewModel {

    var sections: [StoryGroup] = []
    let disposeBag = DisposeBag()
    
    let userID = "7C34hG7C8CZllF0WvI6fSZfJIA43"
    
    let service: StoryService
    
    var story_reel: Observable<[StoryGroup]> {
        return reels.asObservable()
    }
    
    private let reels = BehaviorRelay<[StoryGroup]>(value: [])
    
    init(service: StoryService = StoryService()) {
        self.service = service
    }
    
    func setupReel() {
        
        service.loadStoryReel(userId: userID).subscribe(onNext: { (stories) in
            self.reels.accept(stories)
        }, onError: { (error) in
            print("error:  \(error)")
        }, onCompleted: {
            print("complete")
        }).disposed(by: disposeBag)
    }
    
    func loadStories(users: [String]) {
        
    }
}
