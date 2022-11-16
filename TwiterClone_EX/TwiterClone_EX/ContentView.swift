//
//  ContentView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/08.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @State private var showMenu = false
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        Group{  //뷰가 11개 이상일때 컴파일 오류가 뜨는것을 방지
            //로그인이 안되있을 때
            if vm.userSession == nil{
                LoginView()
            }
            //로그인이 되어있을 때
            else{
                mainInterfaceView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }.environmentObject(AuthViewModel())
    }
}
extension ContentView{
    var mainInterfaceView:some View{
        ZStack(alignment: .topLeading){
            MainTabView()
                .navigationBarHidden(showMenu)
            if showMenu{
                ZStack{
                    Color.primary
                        .opacity(showMenu ?  0.25:0)
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        showMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            SideMenuView() 
                .frame(width: 300)
                .offset(x:showMenu ? 0: -300)
                .background(showMenu ?  Color.black:Color.clear)
        }
        .navigationTitle("홈")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                if let user = vm.currentUser{
                    Button {
                        withAnimation(.easeInOut){
                            showMenu.toggle()
                        }
                    } label: {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30,height: 30)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .onAppear{
           showMenu = false //홈화면 이동시 메뉴창 닫기
        }
    }
}
