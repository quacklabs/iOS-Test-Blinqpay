//
//  StoryService.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 28/03/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseFirestore

class StoryService {
    
    let db = Firestore.firestore()
    var isLoading = false
    
    // get stories of people i am following
    func loadStoryReel(userId: String) -> Observable<[StoryGroup]> {
       
        return Observable.create { (observer) -> Disposable in
            var storyList = [StoryGroup]()
            self.db.collection("following/\(userId)/users").getDocuments { (snapshot, error) in
                if let documents = snapshot?.documents {
                    let list = documents.map { $0.documentID }
                    
                    observer.onNext(storyList)
                    
                    for user in list {

                        self.load_userStory(user: user, callback: { stories in
                            storyList.appendDistinct(contentsOf: [stories]) { (old, new) -> Bool in
                                return old.user_id != new.user_id
                            }
                            observer.onNext(storyList)
                        })
                    }
                    self.isLoading = false
                } else {
                    print("error: \(error)")
                    self.isLoading = false
                
                }
            }
            return Disposables.create()
        }
    }
    
    
    private func load_userStory(user: String, callback: @escaping  (StoryGroup) -> Void) {
        self.db.collection("story/\(user)/statuses").getDocuments { (snapshot, error) in
            if let statuses = snapshot?.documents {
                for status in statuses {
                    print("status: \(status.data())")
                }
            } else {
                print("error: \(error)")
            }
        }
    }
}
