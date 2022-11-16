//
//  ImgaePicker.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/11.

import SwiftUI
import PhotosUI


class ImagePickerClass:ObservableObject{
    
    @Published var selectItem:[PhotosPickerItem] = []   //사진 피커 화면
    @Published var selectPhotoItem:[Data] = []  //실제 저장 사진
    
    init(){
        selectPhotoItem.removeAll() //사진을 새로 선택할 때마다 상태변경
    }
    
    func selectPhoto(item:[PhotosPickerItem]) {
        Task {  //사진 저장 동기처러
            for newItem in item {
                //Task - 비동기
                if let data = try? await newItem.loadTransferable(type: Data.self) {
                    selectPhotoItem.append(data)
                    print("현재 사진 선택 상태 : \(selectPhotoItem)")
                    print("현재 업로드된 사진 상태 : \(selectItem)")
                }
            }
        }
    }
}
