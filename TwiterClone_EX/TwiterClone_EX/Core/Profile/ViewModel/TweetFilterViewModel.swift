//
//  TweetFilterViewModel.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/08.
//

import Foundation
//import
    

//CaseIterable - enum값들을 배열처럼 순회할 수 있는 프로토콜 
enum TweetFilterViewModel:Int,CaseIterable{
    case tweets
    case replies
    case likes
    
    var titile:String{
        switch self{
        case .tweets: return "트윗"
        case .replies: return "댓글"
        case .likes: return "좋아요"
        }
    }
}
