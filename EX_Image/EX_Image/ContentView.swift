//
//  ContentView.swift
//  EX_Image
//
//  Created by 유영웅 on 2022/09/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            RadialGradient(colors: [.gray,.white], center: .center, startRadius: 100, endRadius: 500).ignoresSafeArea()
            VStack {
                Text("INTJ ALBUM").font(.largeTitle).bold()
                Spacer()
                Image("INTJ")
                    //.renderingMode(.template)   //단색모양일경우
                    .resizable()    //프레임화면에 맞춰서 변형
                    .scaledToFill()
                    .frame(width: 300,height: 300)
                    //.foregroundColor(.red)//renderingMode와 같이 사용
                    .ignoresSafeArea()//프레임 화면에 맞춤
                    .clipped()
                    .cornerRadius(20)   //모서리
                    .clipShape(Circle())    //특정모양으로 자름
                    .overlay(Circle().fill(RadialGradient(colors: [.gray,.white], center: .center, startRadius: 1, endRadius: 100)).frame(width: 100,height: 100))    //이미지 중점으로 뷰를 중첩
                Text("quarang(feat-INTJ)")
                Spacer()
                
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
