//
//  MainTabView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/08.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 1
    
    init(){
        UITabBar.appearance().backgroundColor = .gray
    }
    var body: some View {
        TabView(selection: $selectedIndex){
            FeedView()
                .toolbarBackground(.red, for: .tabBar)
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem{
                    Image(systemName : "house")
                }.tag(0)
            ExploreView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem{
                    Image(systemName : "magnifyingglass")
                }.tag(1)
            NotificationView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem{
                    Image(systemName : "bell.fill")
                }.tag(2)
            MessagesView()
                .onTapGesture {
                    self.selectedIndex = 3
                }
                .tabItem{
                    Image(systemName : "message.fill")
                }.tag(3)
        }.accentColor(.red)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
            MainTabView()
        
        
    }
}
