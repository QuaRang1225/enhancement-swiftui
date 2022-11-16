//
//  TweetService.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/15.
//

import Firebase

struct TweetService{
    func uploadTweet(caption:String,completion:@escaping(Bool)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data = ["uid" : uid,
                    "caption" : caption,
                    "likes" : 0,
                    "timestemp" : Timestamp(date:Date())] as [String:Any]
        Firestore.firestore().collection("tweet")
            .document().setData(data){ error in
                if let error = error{
                    print("게시물 업로드 실패 \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    func fetchTweet(completion:@escaping([Tweet])->Void){
        Firestore.firestore().collection("tweet")
            .order(by: "timestemp", descending: true)   //가장 최근 피드를 상단으로 가게 하기 위함
            .getDocuments { snapshot, _ in
                guard let document = snapshot?.documents else{return}
                let tweet = document.compactMap({try? $0.data(as: Tweet.self)})
                completion(tweet)
            }
    }
    func fetchTweet(uid:String,completion:@escaping([Tweet])->Void){
        Firestore.firestore().collection("tweet")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let document = snapshot?.documents else{return}
                let tweet = document.compactMap({try? $0.data(as: Tweet.self)})
                completion(tweet.sorted(by: {$0.timestemp.dateValue() > $1.timestemp.dateValue() }))    //시간순으로 정렬
            }
    }
    func likeTweet(_ tweet:Tweet,compeltion:@escaping ()->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else{return}
        
        let userLike = Firestore.firestore().collection("user").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweet").document(tweetId)
            .updateData(["likes":tweet.likes + 1]){ _ in
                userLike.document(tweetId).setData([:]){ _ in
                    compeltion()
                    print("좋아요")
                    
                }
            }
    }
    func unlikeTweet(_ tweet:Tweet,compeltion:@escaping ()->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else{return} 
        guard tweet.likes >= 0 else{return}
        
        let userLike = Firestore.firestore().collection("user").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweet").document(tweetId)
            .updateData(["likes":tweet.likes - 1]){ _ in
                userLike.document(tweetId).delete { _ in
                    compeltion()
                    print("취소")
                }
            }
    }
    func checkIfUserLikeTweet(_ tweet:Tweet,completion:@escaping (Bool)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else{return}
         
        Firestore.firestore().collection("user")
            .document(uid)
            .collection("user-likes")
            .document(tweetId).getDocument{ snapshot, _ in
                guard let snapshot = snapshot else{return}
                completion(snapshot.exists)
            }
    }
    func fetchLikedTweet(uid:String,completion:@escaping ([Tweet])->Void){
        var tweets = [Tweet]()
        Firestore.firestore().collection("user")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let document = snapshot?.documents else{return}
                document.forEach{ doc in
                    let tweetId = doc.documentID
                    Firestore.firestore().collection("tweet")
                        .document(tweetId)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else {return}
                            tweets.append(tweet)
                            completion(tweets)
                        }
                }
            }
    }
}
