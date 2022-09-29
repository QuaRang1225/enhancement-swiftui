//
//  ContentView.swift
//  EX_LazyVGrid
//
//  Created by 유영웅 on 2022/09/30.
//

import SwiftUI

struct ContentView: View {
    var cloumns:[GridItem] = [
        GridItem(.adaptive(minimum: 100))

        
        //GridItem(.fixed(100)),    //요소 값을 정해놓고 싶을 때 - 값이 여러개 있어도 본인 사이즈는 절대 변하지 않음 (이기적)
        //GridItem(.adaptive(minimum: 100)),    //요소의 값을 지정하고 싶을 때 - minimum을 설정하면 그 값으로 그리드를 나눠줌 ex) 100이라고 하면 100으로 들어갈수 있는 만큼 채우고 나머지는 밑으로 정렬 - 최대한 남는 자리 없이 알아서 정렬시킴 (이타적)
        //GridItem(.flexible(minimum: 100,maximum: 200)) - 일단 자리가 많으면 maximum 자리가 없으면 최소 minimum으로 설정 (그 사이값) 나머지는 세로로 정렬  아이템이 여러개 생길 경우 가로로 정렬 - 일단 본인의 사이즈 안에서 맞춰가고 아이템이 여러개 생기면 최솟값에 따라 본인 사이즈를 맞춰가면서 가로로 정렬 (중립)
    ]
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            Image("MAP").resizable().ignoresSafeArea().opacity(0.5)
            VStack{
//                Spacer()
//                Image("LOGO").resizable().ignoresSafeArea().frame(height: 150).padding(.leading).background(Color("SODA")).cornerRadius(20).padding()
                HStack{
                    Button(action: {
                        //빈곳
                    }){
                        Text("< 뒤로가기").font(.system(size: 20,weight: .black)).shadow(radius: 10).padding(.leading)
                    }
                    Spacer()
                    Button(action: {
                        //빈곳
                    }){
                        Text("다음").font(.system(size: 20,weight: .black)).shadow(radius: 10).padding(.trailing)
                    }
                    
                }
                ScrollView{
                    
                    LazyVGrid(columns: cloumns,alignment: .center,pinnedViews: [.sectionHeaders]){
                        Section(header:
                            HStack{
                            
                            Text("월요일").foregroundColor(.black).font(.system(size: 30,weight: .black)).shadow(radius: 10)
                            Spacer()
                        }
                                    
                        ){
                            ForEach(0..<12){ index in
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .frame(height: 150)
                                    .shadow(radius: 20)
                            }
                        }
                        
                    }
                    .padding()
                    LazyVGrid(columns: cloumns,alignment: .center,pinnedViews: [.sectionHeaders]){  //sectionHeaders = 섹션제목 그리드만큼 따라옴
                        Section(header:
                                    HStack{
                            Text("화요일").foregroundColor(.black).font(.system(size: 30,weight: .black)).shadow(radius: 20)
                            Spacer()
                        }
                                    
                        ){
                            ForEach(0..<12){ index in
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .frame(height: 150)
                                    .shadow(radius: 20)
                            }
                        }
                        
                    }
                    .padding()
                    LazyVGrid(columns: cloumns,alignment: .center,pinnedViews: [.sectionHeaders]){
                        Section(header:
                                    HStack{
                            Text("수요일").foregroundColor(.black).font(.system(size: 30,weight: .black)).shadow(radius: 20)
                            Spacer()
                        }
                                    
                        ){
                            ForEach(0..<12){ index in
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .frame(height: 150)
                                    .shadow(radius: 20)
                            }
                        }
                        
                    }
                    .padding()
                }
            }
        }
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
