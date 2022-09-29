//
//  ContentView.swift
//  EX_InitEnum
//
//  Created by 유영웅 on 2022/09/29.
//

import SwiftUI

struct ContentView: View {
    
    var bgColor:Color = Color.red
    var number:Int = 1
    var script:String = "red"
    
    init(number: Int, bgColorMode: Rainbow) {
        self.number = number
        
        if bgColorMode == .red{
            self.bgColor = Color.red
            self.script = "red"
        }
        else if bgColorMode == .orange{
            self.bgColor = Color.orange
            self.script = "orange"
        }
        else{
            self.bgColor = Color.yellow
            self.script = "yellow"
        }
        
    }
    enum Rainbow{
        case red
        case orange
        case yellow
    }
    var body: some View {
        VStack(spacing:10) {
            Text("\(number)")
                .font(.largeTitle)
                .underline()
                .foregroundColor(.white)
            Text(script)
                .font(.headline)
                .foregroundColor(.white)
            
        }.frame(width:150,height: 150)
        .background(bgColor)
        .cornerRadius(20)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ContentView(number: 1, bgColorMode: .red)
            ContentView(number: 2, bgColorMode: .orange)
            ContentView(number: 3, bgColorMode: .yellow)
        }
        
    }
}
