//
//  ContentView.swift
//  EX_Color
//
//  Created by 유영웅 on 2022/09/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    //.fill(Color.primary)     //다크모드일때 - 흰색/아닐때 - 검정색
                    //.fill(Color(UIColor.secondarySystemBackground)) //배경보다 살짝 진한색
                    //.fill(Color("SODA"))    //지정한색깔
                    //.fill(LinearGradient(gradient: Gradient(colors: [.red,.orange,.yellow,.green,.blue,.indigo,.purple]), startPoint: .leading, endPoint: .trailing))  //그라데이션 색깔 - 시작위치 - 끝 위치
                    //.fill(RadialGradient(gradient: Gradient(colors: [.red,.purple]), center:.center,startRadius: 5, endRadius: 100))//퍼센테이지
                    .fill(AngularGradient(gradient: Gradient(colors: [.red,.purple]), center: .center,angle: .degrees(270)))//각도
                    .frame(width: 300,height: 200)  //원형 그라데이션
                    
                    //.shadow(color: Color("SODA").opacity(0.7), radius: 10,x: 10,y: 10)   //그림자 효과 - opacity : 투명도
                Image(systemName: "heart.fill")
                    .foregroundColor(Color("SODA"))
                    .font(.system(size:300))
                    .aspectRatio(contentMode: .fit) //프레임 맞춤 fill- 프레임 꽉채움 fit - 프레임크기 안쪽 맞춤
                    //.scaledToFit()//scaledFill
                    //.symbolRenderingMode(.hierarchical)//심볼 모드선택 - 아이콘 색깔 변화
                    .clipped()//프레임크기보다 오버되면 오버 부분 자름
                    
            }
        
        
        
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
           //  .preferredColorScheme(.dark)//다크모드설정
    }
}
