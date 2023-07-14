//
//  Tweet.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/15.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet:Identifiable,Codable{
    @DocumentID var id:String?
    let caption:String
    let timestemp:Timestamp
    let uid:String
    var likes:Int      //유저가 변경가능한 값
    
    var user:User?      //유저별로 게시물 상태를 구분하기 위한 모델
    var didLike:Bool? = false
}
