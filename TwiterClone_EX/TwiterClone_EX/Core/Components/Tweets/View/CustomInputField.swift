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
    var securefield:Bool? = false
    @Binding var text:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .foregroundColor(.secondary)
                
                if securefield ?? false{
                    SecureField(placeholderText, text: $text)
                        .autocapitalization(.none)//첫글자 항상 소문자로 시작
                        .textCase(.lowercase)
                }else{
                    TextField(placeholderText, text: $text)
                        .autocapitalization(.none)//첫글자 항상 소문자로 시작
                        .textCase(.lowercase)
                }
            }
            Divider()
                .background(Color.secondary)
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope", placeholderText: "이메일", text: .constant(""))
    }
}
