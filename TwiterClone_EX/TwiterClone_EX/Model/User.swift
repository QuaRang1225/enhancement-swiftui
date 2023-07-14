//
//  User.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/14.
//

import Firebase
import FirebaseFirestoreSwift

struct User:Identifiable,Codable{
    
    @DocumentID var id: String?     //UUID().toString FireStore의 문서 ID 매핑가능
    let email:String
    let username:String
    let nickname:String
    let profileImageUrl:String
    
    var isCurrentUser:Bool {return Auth.auth().currentUser?.uid == id}
}
 
