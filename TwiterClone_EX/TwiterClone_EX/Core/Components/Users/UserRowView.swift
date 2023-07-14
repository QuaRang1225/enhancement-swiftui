//
//  UserRowView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/08.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let user:User
    var body: some View {
        HStack(spacing:10){
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width:50,height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4){
                Text(user.username)
                    .font(.subheadline).bold()
                Text(user.nickname)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical,5)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User(email: "quarang@gmail.com", username: "콰랑", nickname: "quarang", profileImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSayRz__4vNzLz2gzGEM12QerJaDANG8JTxng&usqp=CAU"))
    }
}
