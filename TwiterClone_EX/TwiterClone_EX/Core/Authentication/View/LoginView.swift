//
//  LoginView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var vm:AuthViewModel
    var body: some View {
        
        VStack{
            //헤더
            AuthHeaderView(title1: "안녕,", title2: "반가워요")
            VStack(spacing:40){
                CustomInputField(imageName: "envelope", placeholderText: "이메일", text: $email)
                CustomInputField(imageName: "lock", placeholderText: "비밀번호",securefield:true, text: $password)
            }
            .padding(.horizontal,32)
            .padding(.top,40)
            HStack{
                Spacer()
                NavigationLink{
                    Text("패스워드 뷰")
                }label: {
                    Text("비밀번호를 잊어버리셨나요?")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding()
                }   
            }
            
            Button {
                vm.login(email: email, password: password)
            } label: {
                Text("로그인")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350,height: 50)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(radius: 10)
            Spacer()
            NavigationLink {
                RegisterView()
                    .navigationBarHidden(true)
            } label: {
                HStack{
                    Text("계정이 없으신가요?")
                        .font(.footnote)
                    Text("회원가입")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .padding(.bottom,30)
                .foregroundColor(.blue)
            }

            
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
    }
}
