//
//  SideMenuViewModel.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//

import Foundation

enum SideMenuViewModel:Int,CaseIterable{
    case profile
    case list
    case bookmark
    case logout
    
    var title:String{
        switch self {
        case .profile: return "프로필"
        case .list: return "리스트"
        case .bookmark: return "북마크"
        case .logout: return "로그아웃"
        }
    }
    var imageName:String{
        switch self {
        case .profile: return "person"
        case .list: return "list.bullet"
        case .bookmark: return "bookmark"
        case .logout: return "arrow.left.square"
        }
    }
}
