//
//  TweetRowView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/08.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    @ObservedObject var vmTweet:TweetRowViewModel
    init(tweet:Tweet){
        self.vmTweet = TweetRowViewModel(tweet: tweet)
    }
    var body: some View {
        VStack(alignment: .leading){
            //프로필 사진 + 유저정보 + 트위터피드
            if let user = vmTweet.tweet.user{
                HStack(alignment: .top, spacing: 12){
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 56,height: 56)
                       
                    //유저 정보/트위터 제목
                    VStack(alignment: .leading){
                        //유저정보
                        HStack{
                            Text(user.username)
                                .font(.subheadline).bold()
                            Text("@\(user.nickname)")
                                .foregroundColor(.secondary)
                                .font(.caption)
                            Text("52주")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                        
                        
                        //트위터 제목
                        Text(vmTweet.tweet.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)   //여러줄 본문 위치
                    }
                    
                }
            }
            //액션 버튼
            HStack{
                Button(action: {
                    
                })
                {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                }
                Spacer()
                Button(action: {
                    
                })
                {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                }
                Spacer()
                Button(action: {
                    vmTweet.tweet.didLike ?? false ? vmTweet.unLikeTweet() : vmTweet.likeTweet()
                })
                {
                    Image(systemName:vmTweet.tweet.didLike ?? false  ? "heart.fill":"heart")
                        .font(.subheadline)
                        .foregroundColor(vmTweet.tweet.didLike  ?? false ? .red : .gray)
                }
                Spacer()
                Button(action: {
                    
                })
                {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                }
            }
            .padding()
            .foregroundColor(.gray)
            Divider()
        }
    }
}

//struct TweetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetRowView()
//    }
//}
