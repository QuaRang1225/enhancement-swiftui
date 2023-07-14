//
//  FeedViewModel.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/15.
//

import Foundation

class FeedViewModel:ObservableObject{
    @Published var tweet = [Tweet]()
    let service = TweetService()
    let userService = UserService()
    
    init(){
        fetchTweet()
    }
    func fetchTweet(){
        service.fetchTweet { tweet in
            self.tweet = tweet
            for i in 0..<tweet.count{
                let uid = tweet[i].uid
                self.userService.fetchUser(uid: uid) { user in
                    self.tweet[i].user = user
                }
            }
            
        }
    }
}
