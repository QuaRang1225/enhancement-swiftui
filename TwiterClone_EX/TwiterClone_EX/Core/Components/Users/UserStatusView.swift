//
//  UserStatusView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//

import SwiftUI

struct UserStatusView: View {
    var body: some View {
        HStack(spacing:25){
            HStack{
                Text("5.2M")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .bold()
                Text("팔로워")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            HStack{
                Text("1")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .bold()
                Text("팔로우")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
        
    }
}

struct UserStatusView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatusView()
    }
}
