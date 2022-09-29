//
//  ContentView.swift
//  EX_ForEach
//
//  Created by 유영웅 on 2022/09/29.
//

import SwiftUI

struct ContentView: View {
    let dataArr:[String] = ["moon","cloud","tornado"]
    
    var body: some View {
        VStack {
            ForEach(dataArr.indices){ index in  //.indices = 배열길이만큼
                HStack{
                    Image(systemName:dataArr[index]).font(.system(size: 30)).foregroundColor(.gray)
                    Text("Alphabet : \(dataArr[index])").font(.system(size: 30))
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
