//
//  ProfileView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/08.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct ProfileView: View {
    @State private var selectionFilter: TweetFilterViewModel = .tweets
    @ObservedObject var vm:ProfileViewModel
    @Environment(\.presentationMode) var mode
    @Namespace var animation //matchedGeometryEffect을 사용하기 위한 속성
    @StateObject var imageEdit = ImagePickerClass()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    
    init(user:User){    //프로필 뷰를 볼대마다 유저정보를 업데이트해서 보여줘야하기 위함
        self.vm = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack{
            headerView
            editProfile
            userInfoDetail
            filterView
            tweetsView
            //Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(email: "quarang@gmail.com", username: "콰랑", nickname: "quarang", profileImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSayRz__4vNzLz2gzGEM12QerJaDANG8JTxng&usqp=CAU"))
    }
}

extension ProfileView{
    var headerView:some View{
        ZStack(alignment: .bottomLeading){
            Color.blue.ignoresSafeArea()
            VStack{
                Button(action: {
                    mode.wrappedValue.dismiss()
                }){
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 20,height: 20)
                        .offset(y:10)
                }
                KFImage(URL(string: vm.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70,height: 70)
                    .clipShape(Circle())
                    .offset(x:15 , y: 20)
            }
            
            
        }
        .frame(height: 96)
    }
    var editProfile:some View{
        HStack{
            Spacer()
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(5)
                .overlay(Circle().stroke(Color.secondary,lineWidth: 0.75))
            PhotosPicker(selection: $imageEdit.selectItem, maxSelectionCount: 1, matching: .images) {
                Text(vm.actionButtonTitle)
                    .font(.subheadline).bold()
                    .frame(width: 120,height: 30)
                    .foregroundColor(.primary)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.secondary,lineWidth: 0.75))
            }
            .onChange(of: imageEdit.selectItem,perform: imageEdit.selectPhoto)
            .onAppear{
                for item in imageEdit.selectPhotoItem{
                    if let image = UIImage(data: item){
                        vmAuth.imageUpload(image)
                    }
                }
            }

        }.padding(.trailing,5)
    }
    var userInfoDetail:some View{
        VStack(alignment:.leading,spacing: 5){
            HStack{
                Text(vm.user.username)
                    .bold()
                    .font(.title2)
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            Text("@\(vm.user.nickname)")
                .foregroundColor(.secondary)
                .font(.subheadline)
            Text("iOS개발 1년차 콰랑이라고 합니다 콰하!")
                .foregroundColor(.primary)
                .padding(.vertical)
            HStack(spacing:25){
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                    
                    Text("대전광역시, 서구")
                }
                Spacer()
                HStack{
                    Image(systemName: "link")
                    Text("www.quarang.tistory.com")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            UserStatusView()
                .padding(.vertical)
        }
        .padding(.horizontal)
        
    }
    var filterView:some View{
        HStack{
            //TweetFilterViewModel.allCases - 모든 케이스 범위
            ForEach(TweetFilterViewModel.allCases,id: \.self){ item in
                VStack{
                    Text(item.titile)
                        .font(.subheadline)
                        .fontWeight(selectionFilter == item ? .semibold: .regular)
                        .foregroundColor(selectionFilter == item ? .primary : .secondary)
                    if selectionFilter == item{
                        Capsule()
                            .foregroundColor(.blue)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                            //좀더 부드러운 페이드인/아웃을 위한 메서드 id: 메뉴 고유아이디 in: namespace
                    }
                    else{
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3) 
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectionFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(y:15))
    }
    var tweetsView:some View{
 
        VStack{
            if vm.tweet.isEmpty{
                Spacer()
                Text("게시물 없음")
                    .foregroundColor(.primary)
                    .font(.title)
                    .padding()
                Spacer()
            }
            else{
                ScrollView{
                    LazyVStack{
                        ForEach(vm.tweets(filter: self.selectionFilter)){ tweet in
                            TweetRowView(tweet: tweet)
                                .padding()
                        }
                    }
                    
                }
            }
        }
        
    }
}
