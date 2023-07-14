//
//  ContentView.swift
//  EX_WeakSelf
//
//  Created by 유영웅 on 2022/12/22.
//

import SwiftUI

class Count:ObservableObject{
    
    @Published var count = 0
    @Published var text:String?
    
    init(){
        count += 1
        print("1 추가")
        countNum()
    }
    deinit{
        count -= 1
        print("1 차감")
    }
    private func countNum(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 10000){ [weak self] in
            self?.text = "안녕하세요"
        }
    }
}
struct Greeting:View{
    @StateObject var vm = Count()
    var body: some View{
        if let text = vm.text{
            Text("\(text)")
        }
    }
}
struct ContentView: View {
    
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink {
                    Greeting()
                } label: {
                    Text("인사")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
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
