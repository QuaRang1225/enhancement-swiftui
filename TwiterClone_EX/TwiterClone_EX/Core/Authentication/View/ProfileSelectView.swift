//
//  ProfileSelectView.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/11.
//

import SwiftUI
import PhotosUI

struct ProfileSelectView: View {
    

    @EnvironmentObject var vm:AuthViewModel
    @StateObject var vmImagePiceker = ImagePickerClass()
    
    var body: some View {
        VStack{
            AuthHeaderView(title1: "계정 생성 ", title2: "프로필을 선택해 주세요.")
            
            PhotosPicker(selection: $vmImagePiceker.selectItem, maxSelectionCount: 1, matching: .images) {
                    if vmImagePiceker.selectPhotoItem.isEmpty{
                        VStack{
                            Image(systemName: "photo.artframe")
                                .resizable()
                                .renderingMode(.template)
                                .modifier(ProfileImageModifier())
                            Text("추가")
                                .font(.title2)
                                .bold()
                        }
                    }else{
                        ForEach(vmImagePiceker.selectPhotoItem,id: \.self){
                            if let image = UIImage(data: $0){
                                VStack{
                                    Image(uiImage: image)
                                        .resizable()
                                        .clipShape(Circle())
                                        .modifier(ProfileImageModifier())
                                    Button {
                                        vm.imageUpload(image)
                                        print("DEBUG : 회원가입 성공 \(image)")
                                    } label: {
                                        Text("완료")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(width: 350,height: 50)
                                            .background(Color.blue)
                                            .clipShape(Capsule())
                                            .padding()
                                    }
                                    .shadow(radius: 10)
                                }
                                    
                            }
                        }
                    }
                }
                .onChange(of: vmImagePiceker.selectItem,perform: vmImagePiceker.selectPhoto)
            Spacer()
        }.ignoresSafeArea()
    }

   
}
private struct ProfileImageModifier:ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .foregroundColor(.blue)
            .frame(width: 180,height: 180)
            .padding(.top ,120)
            
           
    }
}
struct ProfileSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelectView()
    }
}
