//
//  UploadViewModel.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/15.
//

import Foundation
import Firebase

class UploadViewModel:ObservableObject{
    @Published var didUploadTweet = false
    let service  = TweetService()
    
    func uploadTweet(withCaption caption:String){
        service.uploadTweet(caption: caption){ success in
            if success{
                //창 닫기
                self.didUploadTweet = true
            }else{
                //유저에게 에러메세지 전달
                
            }
        }
    }
}
