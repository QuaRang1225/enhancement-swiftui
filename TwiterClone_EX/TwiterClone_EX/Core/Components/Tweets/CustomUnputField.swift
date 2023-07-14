//
//  CustomUnputField.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//

import SwiftUI

struct CustomInputField: View {
    let imageName:String
    let placeholderText:String
    @Binding var text:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .foregroundColor(.secondary)
                TextField(placeholderText, text: $text)
            }
            Divider()
                .background(Color.secondary)
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomUnputField(imageName: "envelope", placeholderText: "이메일", text: .constant(""))
    }
}
