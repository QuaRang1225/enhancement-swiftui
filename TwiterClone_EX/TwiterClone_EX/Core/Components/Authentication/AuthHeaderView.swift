//
//  AuthHeaderView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//

import SwiftUI

struct AuthHeaderView: View {
    let title1:String
    let title2:String
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
            }
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width,height: 250)
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(title1: "안녕,", title2: "만나서 반가워요")
    }
}
