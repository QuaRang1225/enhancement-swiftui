//
//  ContentView.swift
//  EX_LongPress
//
//  Created by 유영웅 on 2022/12/20.
//

import SwiftUI

struct ContentView: View {
    @State var isActive:Bool = false
    @State var isSuccess:Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isActive ? .infinity:0)
                .frame(height: 55)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(Color.gray)
            HStack{
                Text("버튼")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { isPressing in
                        //누르기 시작부터 최소 지속시간까지
                        if isPressing{  //누르는 중일때
                            withAnimation(.easeOut(duration: 1.0)){
                                isActive = true
                            }
                        }else{  //누르지 않을 때
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                if !isSuccess{  //게이지가 모두 차지 않았다면
                                    withAnimation(.easeOut){
                                        isActive = false
                                    }
                                }
                            }
                        }
                    } perform: {    //최소지속시간이 지났을때
                        withAnimation(.easeOut){
                            isSuccess = true
                        }
                    }

                Text("리셋")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isSuccess = false
                        isActive = false
                    }
                
            }
            
            Spacer()
            Text("Hello, world!")
                .padding()
                .background(isActive ? Color.green:Color.gray)
                .cornerRadius(10)
                .onLongPressGesture(minimumDuration:1.0,maximumDistance: 50){
                    //minimumDuration 최소 누름 시간
                    //maximumDistance 누른상태로 손가락을 움직여도 감지할 수 있는 최대 거리
                    isActive.toggle()
                }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
