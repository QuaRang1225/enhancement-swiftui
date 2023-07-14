//
//  TextArea.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//

import SwiftUI

struct TextArea: View {
    @Binding var text:String
    let placeholder:String
    
    init(_ placeholder:String, text: Binding<String>){
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            if text.isEmpty{
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal,10)
                    .padding(.vertical,10)
            }
            TextEditor(text: $text)
                .scrollContentBackground(Visibility.hidden) //iOS 16버전 부터 추가해야함
                .padding(4)
        }
        .font(.body)
       
    }
}

//struct TextArea_Previews: PreviewProvider {
//    @State var caption = ""
//    static var previews: some View {
//        TextArea("내용을 입력해주세요", text: $caption)
//    }
//}
