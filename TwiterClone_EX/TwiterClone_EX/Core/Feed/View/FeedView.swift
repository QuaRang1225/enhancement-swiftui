//
//  FeedView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/08.
//

import SwiftUI

struct FeedView: View {
    @State  private var showNewTweetView = false
    @ObservedObject var vm = FeedViewModel()
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            ScrollView{
                LazyVStack{
                    ForEach(vm.tweet){ tweet in
                        TweetRowView(tweet: tweet)
                            .padding()
                    }
                }
            }
            Button {
                showNewTweetView.toggle()
            } label: {
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .renderingMode(.template)
                    .bold()
                    .frame(width: 30,height: 30)
                    .padding()
            }
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showNewTweetView){
                NewTweetView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
