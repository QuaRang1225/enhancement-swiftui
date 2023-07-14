//
//  ContentView.swift
//  TestList
//
//  Created by 유영웅 on 2023/02/13.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.pink.opacity(0.5).ignoresSafeArea()
                List{
                    ForEach(0...19,id:\.self){ item in
                        NavigationLink {
                            Text("\(item)")
                        } label: {
                            Text("\(item)")
                        }.listRowBackground(Color.clear)
                    }
                }.listStyle(.plain).scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    .refreshable {
                        
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
