//
//  User.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/14.
//

import Firebase
import FirebaseFirestoreSwift

struct User:Identifiable,Codable{
    @DocumentID var id: String?
    let email:String
    let username:String
    let nickname:String
    let profileImageUrl:String
    
    var isCurrentUser:Bool {return Auth.auth().currentUser?.uid == id}
}
 
