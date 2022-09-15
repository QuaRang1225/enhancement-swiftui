//
//  ContentView.swift
//  EX_State
//
//  Created by 유영웅 on 2022/09/13.
//

import SwiftUI

struct ContentView: View {
    
    @State var backgroundColor:Color = .red
    @State var content:String = "빨간색"
    @State var count:Int = 0
    
    var body: some View {
        ZStack{
            
            backgroundColor.ignoresSafeArea() //배경색
            
            VStack(spacing:10){
                Text("버튼을 클릭하시오").font(.title).foregroundColor(.white)
                Text("현재 색깔: " + content).font(.system(size: 20)).fontWeight(.bold).foregroundColor(.white)
                Text("count:  \(count)").font(.headline).foregroundColor(.white)
                HStack{
                    Button(action: {
                        backgroundColor = .purple
                        content = "보라색"
                        count += 1
                    }){
                        Text("보라색").font(.system(size: 20)).fontWeight(.bold).foregroundColor(.white)
                    }
                    Button(action: {
                        backgroundColor = .red
                        content = "빨간색"
                        count += 1
                    }){
                        Text("빨간색").font(.system(size: 20)).fontWeight(.bold).foregroundColor(.white)
                    }
                }
            }.background(backgroundColor)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
