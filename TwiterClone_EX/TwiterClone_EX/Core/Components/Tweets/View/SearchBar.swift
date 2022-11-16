//
//  SearchBar.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/15.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text:String
    var body: some View {
        HStack{
            TextField("검색어를 입력해주세요..", text: $text)
                .padding()
                .padding(.leading,30)
                .background(Color.secondary.opacity(0.3))
                .cornerRadius(10)
                .overlay {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                            .padding( )
                    }
                }
        }
        .padding(.horizontal,5)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
