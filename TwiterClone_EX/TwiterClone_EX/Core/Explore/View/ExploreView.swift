//
//  ExploreView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/08.
//

import SwiftUI

struct ExploreView: View {
   
    @ObservedObject var vm = SearchViewModel()
    var body: some View {
            VStack{
                SearchBar(text: $vm.searchText)
                    .padding(.vertical)
                ScrollView{
                    LazyVStack{
                        ForEach(vm.searchableUser){ user in
                            NavigationLink{
                                ProfileView(user: user)
                            }label: {
                                UserRowView(user: user)
                            } 
                        }
                    }
                }
            }
            .navigationTitle("검색")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ExploreView()
        }
    }
}
