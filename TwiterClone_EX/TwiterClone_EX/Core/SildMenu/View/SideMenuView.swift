//
//  SideMenuView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        if let user = vm.currentUser{
            VStack(alignment: .leading,spacing: 30){
                VStack(alignment: .leading){
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 40,height: 40)
                       
                    VStack(alignment: .leading, spacing: 5){
                        Text(user.username)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("@\(user.nickname)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    UserStatusView()
                        .padding(.vertical)
                }
                .padding(.leading)
                ForEach(SideMenuViewModel.allCases,id: \.rawValue){ item in
                    if item == .profile{
                        NavigationLink{
                            ProfileView(user: user)
                        }label:{
                           SideMenuRowView(vm: item)
                        }
                    }else if item == .logout{
                        Button {
                            vm.logOut()
                            print("로그아웃")
                        } label: {
                            SideMenuRowView(vm: item)
                        }
                    }else {
                        SideMenuRowView(vm: item)
                    }
                    
                }
                
                Spacer()
            }
        }
        
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView().environmentObject(AuthViewModel())
    }
}

