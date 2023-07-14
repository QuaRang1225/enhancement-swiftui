//
//  SideMenuRowView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/09.
//

import SwiftUI

struct SideMenuRowView: View {
    let vm:SideMenuViewModel
    var body: some View {
        HStack(spacing:15){
            Image(systemName: vm.imageName)
                .font(.headline)
                .foregroundColor(.primary)
            Text(vm.title)
                .foregroundColor(.primary)
                .font(.subheadline)
            Spacer()
        }
        .frame(height:40)
        .padding(.horizontal)
    }
}

struct SideMenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuRowView(vm: .profile)
    }
}
