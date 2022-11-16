//
//  ProfileViewModel.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/17.
//

import Foundation

class ProfileViewModel:ObservableObject{
    
    @Published var tweet:[Tweet] = []
    @Published var likeTweet:[Tweet] = []
    private let service = TweetService()
    private let userService = UserService()
    let user:User
    
    init(user:User){
        self.user = user
        self.fetchUserTweet()
        self.fetLikedTweet()
    }
    var actionButtonTitle: String {
        return user.isCurrentUser ? "프로필 편집" : "팔로우"
    }
    func tweets(filter:TweetFilterViewModel) ->[Tweet] {
        switch filter{
        case .tweets:
            return tweet
        case .likes:
            return likeTweet
        case .replies:
            return  tweet
        }
    }
    func fetchUserTweet(){
        guard let uid = user.id else{return}
        service.fetchTweet(uid: uid) { tweet in
            self.tweet = tweet
            for i in 0..<tweet.count{
                self.tweet[i].user = self.user
            }
        }
    }
    func fetLikedTweet(){
        guard let uid = user.id else{return}
        
        service.fetchLikedTweet(uid: uid) { tweets in
            self.likeTweet = tweets
            
            for i in 0..<tweets.count{
                let uid = tweets[i].uid
                self.userService.fetchUser(uid: uid) { user in
                    self.likeTweet[i].user = user
                }
            }
        }
    }
}
