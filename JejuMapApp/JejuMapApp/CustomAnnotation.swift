//
//  CustomAnnotation.swift
//  JejuMapApp
//
//  Created by 유영웅 on 2023/07/14.
//

import SwiftUI
import MapKit

struct CustomAnnotation: View {
    let item:MapAnnotationItem
    var body: some View {
        VStack{
            Text("\(item.index). \(item.placeName)")
                .offset(y:-25)
                .bold()
                .foregroundColor(.primary)
            Circle()
                .frame(width: 50,height: 50)
                .shadow(color: .primary,radius: 20)
                .overlay {
                    Image(systemName: item.image)
                        .foregroundColor(.white)
                    Image(systemName: "triangle.fill")
                        .offset(y:-25)
                        .rotationEffect(Angle(degrees: 180))
                }
                .foregroundColor(.red)
                .offset(y:-25)
        }
            
    }
}

struct CustomAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        CustomAnnotation(item: MapAnnotationItem(index: 1, image: "airplane",placeName: "제주공항", coordinate: CLLocationCoordinate2D(latitude: 33.509597, longitude: 126.491504),location: "제주특별자치도 제주시 공항로 2", naverLink: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%A0%9C%EC%A3%BC%EA%B3%B5%ED%95%AD", time: ""))
    }
}
