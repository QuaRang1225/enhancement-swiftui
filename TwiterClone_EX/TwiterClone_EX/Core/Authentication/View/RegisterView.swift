//
//  RegisterView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var nickname = ""
    @State private var username = ""
    @Environment(\.presentationMode) var presentMode
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        VStack{
            NavigationLink(destination: ProfileSelectView(),
                           isActive: $vm.didAuthenticationUser,
                           label: {})
            
            AuthHeaderView(title1: "시작하기,", title2: "계정을 추가해주세요")
            VStack(spacing: 40){
                CustomInputField(imageName: "envelope", placeholderText: "이메일", text: $email)
                CustomInputField(imageName: "person.fill", placeholderText: "이름", text: $username)
                CustomInputField(imageName: "person.circle.fill", placeholderText: "아이디", text: $nickname)
                CustomInputField(imageName: "lock", placeholderText: "비밀번호",securefield:true, text: $password)
            }
            .padding(30)
            Button {
                vm.register(email: email.lowercased(), password: password.lowercased(), username: username.lowercased(), nickname: nickname.lowercased())
                print("회원가입 성공")
            } label: {
                Text("회원가입")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350,height: 50)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(radius: 10)
            Spacer()
            Button {
                presentMode.wrappedValue.dismiss()
            } label: {
                HStack{
                    Text("계정이 이미 있으신가요?")
                        .font(.footnote)
                    Text("로그인")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .padding(.bottom,30)
                .foregroundColor(.blue)
            }
        }.ignoresSafeArea()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environmentObject(AuthViewModel())
    }
}
