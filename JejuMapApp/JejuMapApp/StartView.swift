//
//  StartView.swift
//  JejuMapApp
//
//  Created by 유영웅 on 2023/07/14.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                Image("har")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                    .padding(.bottom)
                Text("여경&영웅 제주도여행 계획어플")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
            }
            
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
