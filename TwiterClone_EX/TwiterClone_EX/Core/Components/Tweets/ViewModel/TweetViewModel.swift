//
//  TweetViewModel.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/17.
//

import Foundation

class TweetRowViewModel:ObservableObject{
    //@Published
    private let service = TweetService()
    @Published var tweet:Tweet
    
    init(tweet:Tweet){
        self.tweet = tweet
        checkIfUserLikeTweet()
    }
    func likeTweet(){
        service.likeTweet(tweet) {
            self.tweet.didLike = true
        }
    }
    func unLikeTweet(){
        service.unlikeTweet(tweet) {
            self.tweet.didLike = false
        }
    }
    func checkIfUserLikeTweet(){
        service.checkIfUserLikeTweet(tweet) { didLike in
            if didLike{
                self.tweet.didLike = true
            }
        }
    }
}
