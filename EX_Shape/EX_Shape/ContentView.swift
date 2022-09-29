//
//  ContentView.swift
//  EX_Shape
//
//  Created by 유영웅 on 2022/09/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            //Circle()    //원
            //Ellipse()   타원
            //Capsule(style: .continuous)    //캡슐모양
            //Rectangle()     //사각형
            RoundedRectangle(cornerRadius: 20)     //둥근 사각형
                //.fill(.blue)
                //.foregroundColor(.red)
                //.stroke(Color.red)    //태두리
                //.stroke(Color.red,lineWidth: 30)  //태두리 선굵기(선 기준으로 안쪽 바깥쪽 둘다)
                //.stroke(Color.red,style: StrokeStyle(lineWidth: 30,lineCap: .round,dash: [50]))  //태두리 스타일 : 선 굵기, 테두리모양 - 도형스타일, 간격
                .trim(from:0.2,to:1.0)//퍼센트 - 변화량 / 시작량
                .stroke(Color.red,style : StrokeStyle(lineWidth: 20,lineCap:.round))
            Text("Hello Wolrd!")
                .font(.system(size: 30)).foregroundColor(.red).fontWeight(.semibold)
                //.bold()   //볼드체
                //.underline()    //밑줄
                //.underline(true,color: Color.red)   //밑줄 스타일
                //.italic() //밑줄시 ,기호 건너뜀
                //.strikethrough()  //중간줄
                //.font(.system(size:30,weight: .semibold,design: .serif)).foregroundColor(Color.red)   //한줄로 설정가능
                //.baselineOffset(30) //글 간격(엔터)
                //.kerning(10)    //글 간격(스페이스)
                //.multilineTextAlignment(.leading)   //프레임 왼쪽 정렬 trailling = 오른쪽 정렬
                .frame(width: 100,height: 100)
                .minimumScaleFactor(0.5)    //프레임 알맞게 작게 맞춤
            
            
            
                
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
