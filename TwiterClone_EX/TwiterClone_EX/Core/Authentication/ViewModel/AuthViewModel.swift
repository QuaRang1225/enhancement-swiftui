//
//  AuthViewModel.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//


import SwiftUI
import Firebase

class AuthViewModel:ObservableObject{
    
    @Published var userSession:FirebaseAuth.User?
    @Published var didAuthenticationUser = false
    @Published var currentUser:User?
    
    private var tempUserSession:FirebaseAuth.User?
    private var service = UserService()
    
    init(){
        self.userSession = Auth.auth().currentUser  //사용자 로그인 여부
        fetchUser()
    }
    func login(email:String,password:String){
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if let error = error{
                print("로그인에 실패했습니다. 에러명 : \(error)")
                return
            }
            guard let user = result?.user else{ return }    //유저정보가 비어있다면 반환
            self.userSession = user //유저 로그인 정보 로그인 여부에 전달
            self.fetchUser()    //로그인할때마다 사용자 정보를 업뎅
            print("DEBUG: 로그인에 성공했습니다! 유저이름 : \(self.userSession!)")
            
        }
    }
    func register(email:String,password:String,username:String,nickname:String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in //회원가입
            if let error = error{
                print("회원가입에 실패했습니다. 에러명 : \(error)")
                return
            }
            guard let user = result?.user else{ return }    //유저정보가 비어있다면 반환
            self.tempUserSession = user //유저 회원가입 정보 로그인 여부에 전달
            
            //print("DEBUG: 회원가입에 성공했습니다! 유저이름 : \(self.userSession)")
            //여기까진 회원가입 정보 프로그램 변수에 저장 ///
            

            let data = ["email":email,"password":password,"username":username,"nickname":nickname,"uid":user.uid]   //회원가입 정보를 데이터에 저장
            Firestore.firestore().collection("user")    //"user" 데이터베이스에 저장
                .document(user.uid) //문서명 유저.uid로 설정
                .setData(data) { _ in       //데이터 저장 시 변경 사항
                    self.didAuthenticationUser = true           //회원정보 저장 후 프로필 사진 변경 화면으로 넘어가기 위함
                    print("DEBUG : 유저정보가 업로드 되었습니다. 프로필 사진 변경")
                }
        }
    }
    func logOut(){
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func imageUpload(_ image:UIImage){
        guard let uid = tempUserSession?.uid else{ return } //유저정보가 등록되어있지 않으면 반환
        
        ImageUploader.uploadImage(image: image){ profileImageUrl in
            Firestore.firestore().collection("user")    //user에 정보 저장
                .document(uid)  //document는 uid값으로 지정
                .updateData(["profileImageUrl":profileImageUrl]){ _ in
                    self.userSession = self.tempUserSession //userSession - 어플 전체에서 사용될 유저 정보, tempUserSession - 클래스내에서 메서드 실행 시에 사용될 유저 정보
                    self.fetchUser()    //유저정보가 바뀌어도 모델값의 변함이 없으면 프로필 사진이 변경이 되지 않기 때문에 주기적으로 이미지를 변경하기 위함
                }
        }
    }
    func fetchUser(){
        guard let uid = self.userSession?.uid else { return }
        service.fetchUser(uid: uid){ user in
            self.currentUser = user
        }
    }
}

