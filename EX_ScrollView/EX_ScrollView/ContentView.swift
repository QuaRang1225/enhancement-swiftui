//
//  ContentView.swift
//  EX_ScrollView
//
//  Created by 유영웅 on 2022/09/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ScrollView{
                LazyVStack{ //스크롤바의 범위 Lazy일 경우 화면에 맞춰서 아닐경우 뷰 바로 옆에 생김
                    ForEach(0..<10){ index in
                        ScrollView(.horizontal,showsIndicators: false,content: {    //스크롤뷰 방향/스크롤바 유뮤/스크롤바 속성
                            LazyHStack{
                                ForEach(0..<10){index in
                                    RoundedRectangle(cornerRadius: 20).fill(.white).frame(width: 300,height: 200).shadow(radius: 10)
                                        .padding()
                                }
                            }.ignoresSafeArea()
                        })
                            
                        
                    }
                }
            }
            
        }
        .padding()
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
