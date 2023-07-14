//
//  TestView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/12/28.
//

import SwiftUI

class TestVm:ObservableObject{
    @Published var isactive = 1
    @Published var ac = true
}
struct TabViewItem:View{
    @EnvironmentObject var vm:TestVm
    @Binding var aaa:Bool
    var body: some View{
        ZStack{
            Color.gray.ignoresSafeArea()
            Button("눌러"){
                aaa.toggle()
            }
            //Text("안녕")
        }
        
    }
}
struct Menu:View{
    var body: some View{
        ZStack{
            Color.pink.ignoresSafeArea()
        }
    }
}
struct TestView: View {
    @StateObject var vm = TestVm()
    @State var aaa:Bool
    var body: some View {
        ZStack{
            VStack{
                
                TabView(selection: $vm.isactive) {
                    ZStack{
                        Color.red.opacity(0.5).ignoresSafeArea()
                        Image(systemName: "heart")
                        
                    }
                        .tabItem {
                            Image(systemName: "heart")
                        }.tag(0)
                    ZStack{
                        Color.blue.opacity(0.5).ignoresSafeArea()
                        VStack{
                            Image(systemName: "house")
                            TabViewItem(aaa: $aaa).frame(width: 300,height: 100)
                            
                        }
                        
                        
                    }
                        .tabItem {
                            Image(systemName: "house")
                        }.tag(1)
                }.accentColor(.white)
                if aaa{
                    Menu().frame(width: 300,height: 300)
                }
            }
            
        }
       
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(aaa:false).environmentObject(TestVm())
    }
}
