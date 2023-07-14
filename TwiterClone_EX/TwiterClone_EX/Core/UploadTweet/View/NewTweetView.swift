//
//  NewTweetView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @State private var caption = ""
    @Environment(\.presentationMode) var presentMode
    @EnvironmentObject var  vm:AuthViewModel
    @ObservedObject var vmUpload = UploadViewModel()
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentMode.wrappedValue.dismiss()  //현재 화면 닫기
                } label: {
                    Text("닫기")
                        .foregroundColor(.blue)
                }
                Spacer()
                Button {
                    vmUpload.uploadTweet(withCaption: caption)
                } label: {
                    Text("업로드")
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }

            }
            .padding()
            
            HStack(alignment: .top){
                if let user = vm.currentUser{
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 60,height: 60)
                }
                TextArea("내용을 입력해 주십시오..", text: $caption)
            }
            .padding()
        }
        .onReceive(vmUpload.$didUploadTweet) { success in
            if success{
                presentMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
