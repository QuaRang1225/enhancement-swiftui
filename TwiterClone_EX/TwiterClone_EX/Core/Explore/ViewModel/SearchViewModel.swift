//
//  SearchViewModel.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/15.
//

import Foundation

class SearchViewModel:ObservableObject{
    @Published var users = [User]()
    @Published var searchText = ""
    let service = UserService()
    
    var searchableUser:[User]{
        if searchText.isEmpty{  //검색바가 비어있을 때는 전체유저 모두 보여줌
            return users
        }else{
            let lowercaseQuery = searchText.lowercased()    //검색바의 내용을 문자열에 저장
            return users.filter({   //전체유저 필터 메서드사용
                $0.username.contains(lowercaseQuery) || //문자열을 포함한 이름 보여줌
                $0.nickname.lowercased().contains(lowercaseQuery)   //문자열을 포함한 닉네임 보여줌
            })
        }
    }
    init() {
       fetchUsers() //viewmodel을 사용할 때마다 전체 유저정보 저장
    }
    func fetchUsers(){
        service.fetchUsers { users in
            self.users = users
        }
    }
}
