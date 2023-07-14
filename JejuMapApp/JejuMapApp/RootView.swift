//
//  RootView.swift
//  JejuMapApp
//
//  Created by 유영웅 on 2023/07/14.
//

import SwiftUI

struct RootView: View {
    @State var start = false
    var body: some View {
        ZStack{
            if start{
                ContentView()
            }else{
                StartView()
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                withAnimation(.easeIn){
                    start = true
                }
            }
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
