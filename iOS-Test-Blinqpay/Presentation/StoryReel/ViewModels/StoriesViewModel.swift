//
//  StoriesViewModel.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 11/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation
import Firebase
import Signals

class StoriesViewModel {
//    var lastId: String?
    var stories: Dictionary<String, [Story]> = Dictionary<String, [Story]>()
    var users: [String] = [String]()
    
    let db = Firestore.firestore()
    let load = Signal<()>()
    
    func getStories(start: Int) {
        db.collection("story").getDocuments { (snapshot, error) in
            if let err = error {
                print("error: \(err)")
            } else {
                if let documents = snapshot?.documents {
                    
                    for user in documents {
                        let dict = user.data()
                        do {
                            let stories = dict["stories"]
                            if let json = try? JSONSerialization.data(withJSONObject: stories!, options: [.sortedKeys]), let obj = try? JSONDecoder().decode([Story].self, from: json) {
                            
                                if let _ = self.stories["\(user.documentID)"] {
                                    self.stories["\(user.documentID)"]!.appendDistinct(contentsOf: obj) { (old, new) -> Bool in
                                        return old.id != new.id
                                    }
                                } else {
                                    self.stories["\(user.documentID)"] = obj
                                }
                                
                                self.users.appendDistinct(contentsOf: [user.documentID]) { (old, new) -> Bool in
                                    return old != new
                                }
                            }
                        } catch {
                            print("error: \(error)")
                        }
                    }
                    self.load => ()
                }
            }
        }
    }
}
