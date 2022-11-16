//
//  UserService.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/14.
//

import FirebaseFirestoreSwift
import Firebase

struct UserService{
    func fetchUser(uid:String,compeletion:@escaping (User)->Void){  //현제 유저정보
        Firestore.firestore().collection("user")
            .document(uid)
            .getDocument { snapshot, _ in   //데이터베이스에 저장된 내용 읽기
                guard let snapshot = snapshot else {return}
                guard let user = try? snapshot.data(as: User.self) else {return}    //User의 포맷에 맞춰서 user에 저장
                compeletion(user)   //유저 반환
            }
    }
    func fetchUsers(completion:@escaping ([User])->Void){   // 모든 유저정보
        Firestore.firestore().collection("user")
            .getDocuments { snapshot, _ in
                guard let document = snapshot?.documents else{return}
                let users = document.compactMap({ try? $0.data(as: User.self) })    // 배열에 nil을 제거하여 출력할 대 사용 map -> 배열의 내용을 필터링하여 출력하기 위함
                completion(users)
            }
    }
}
