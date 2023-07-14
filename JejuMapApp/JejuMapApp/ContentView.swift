//
//  ContentView.swift
//  JejuMapApp
//
//  Created by 유영웅 on 2023/07/14.
//

import SwiftUI
import MapKit
import CoreLocationUI
import WebKit

struct ContentView: View {
    @State var anno:MapAnnotationItem = MapAnnotationItem(index: 0, image: "airplane",placeName: "제주공항", coordinate: CLLocationCoordinate2D(latitude: 33.509597, longitude: 126.491504),location: "제주특별자치도 제주시 공항로 2", naverLink: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%A0%9C%EC%A3%BC%EA%B3%B5%ED%95%AD", time: "시간")
    @State var currentIndex = 0
    @State var isOpen = false
    @StateObject var vm = LocationMagager()
    @State var region = MKCoordinateRegion()
    let findLoad = "https://m.search.naver.com/search.naver?query=%EB%B9%A0%EB%A5%B8%EA%B8%B8%EC%B0%BE%EA%B8%B0&nso_path=placeType%5Eplace%3Bname%5E%3Baddress%5E%3Blongitude%5E%3Blatitude%5E%3Bcode%5E%7Ctype%5Eplace%3Bname%5E%3Baddress%5E%3Blongitude%5E%3Blatitude%5E%3Bcode%5E%7Cobjtype%5Epath%3Bby%5Epubtrans"
    
    @State var pick = "첫째날"
    var pickerItem = ["첫째날","둘째날","셋째날","넷째날"]
    @State var day = LocationDay.shared.firstDay
    
    

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom){
                
                Map(coordinateRegion: $region,interactionModes: .all, showsUserLocation: true,annotationItems:day){ item in
                    MapAnnotation(coordinate: item.coordinate) {
                        Button {
                            DispatchQueue.main.async {
                                withAnimation(.linear){
                                    anno = item
                                    isOpen = true
                                    region = MKCoordinateRegion(center:item.coordinate, span: vm.mySpan)
                                }
                            }
                        } label: {
                            CustomAnnotation(item: item)
                        }
                    }
                }
                .ignoresSafeArea()
                Text("제주도")
                    .bold()
                    .font(.title)
                    .padding()
                    .frame(maxHeight: .infinity,alignment: .top)
                    .shadow(radius: 10)
                Button{
                    vm.cheackLocation()
                } label: {
                    Circle()
                        .frame(width:40,height: 40)
                        .foregroundColor(.white)
                        .overlay {
                            Image(systemName: "dot.viewfinder")
                                .foregroundColor(.gray)
                        }
                        .shadow(radius: 10)
                        .padding()
                    
                    
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .frame(maxHeight: .infinity,alignment: .top)
                Picker("", selection: $pick) {
                  ForEach(pickerItem, id: \.self) {
                      Text("\($0)")
                          .foregroundColor(.red)
                  }
                }
                .pickerStyle(.segmented)
                .cornerRadius(15)
                .padding()
                .frame(maxHeight: .infinity,alignment:.top)
                .padding(.top,70)
                
                if isOpen{
                    VStack{
                        HStack{
                            Spacer()
                            Text("내리기")
                            Image(systemName: "chevron.down")
                        }
                        .onTapGesture {
                            withAnimation {
                                isOpen = false
                            }
                        }
                        
                        .bold()
                        .shadow(radius: 10)
                        .padding(.trailing)
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 250)
                            .overlay {
                                HStack{
                                    VStack(alignment: .leading,spacing: 20){
                                        HStack{
                                            Image(systemName:anno.image)
                                                .font(.title)
                                                .padding(.trailing,10)
                                            Text(anno.placeName)
                                                .font(.title3)
                                            Spacer()
                                        }
                                        .bold()
                                        
                                        Text(anno.location)
                                            .font(.caption)
                                        NavigationLink {
                                            MyWebView(urlToLoad: anno.naverLink)
                                        } label: {
                                            HStack{
                                                Image("네이버")
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 30,height: 30)
                                                    .clipShape(Circle())
                                                Text("네이버링크")
                                                    .foregroundColor(.green)
                                                    .bold()
                                                    .underline()
                                            }
                                            
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .foregroundColor(.black)
                                    
                                    
                                    VStack(alignment: .trailing){
                                        Text(anno.time)
                                            .foregroundColor(.gray)
                                            .padding(20)
                                        Spacer()
                                        HStack{
                                            Group{
                                                Button {
                                                    withAnimation(.linear){
                                                        currentIndex = (currentIndex - 1 + day.count) % day.count
                                                        anno = day[currentIndex]
                                                        region = MKCoordinateRegion(center:anno.coordinate, span: vm.mySpan)
                                                    }
                                                    
                                                } label: {
                                                    Image(systemName: "chevron.left")
                                                }
                                                Button {
                                                    withAnimation(.linear){
                                                        currentIndex = (currentIndex + 1) % day.count
                                                        anno = day[currentIndex]
                                                        region = MKCoordinateRegion(center:anno.coordinate, span: vm.mySpan)
                                                    }
                                                } label: {
                                                    Image(systemName: "chevron.right")
                                                }
                                            }
                                            .padding()
                                            .foregroundColor(.black)
                                            .bold()
                                            .font(.title)
                                        }
                                        .padding(.bottom,30)
                                       Spacer()
                                    }
                                    
                                }
                                
                            }
                            
                    }
                    .foregroundColor(.white)
                    .offset(y:100)
                    
                }
            }
            .onReceive(vm.regionSuccess) {
                DispatchQueue.main.async {
                    withAnimation(.easeIn(duration: 0.5)){
                        region = MKCoordinateRegion(center:vm.mapCoordinate, span: vm.mySpan)
                    }
                }
            }
            .onChange(of: pick) { newValue in
                print(newValue)
                switch newValue{
                case "첫째날":
                    day = LocationDay.shared.firstDay
                    anno = day[0]
                    region = MKCoordinateRegion(center:anno.coordinate, span: vm.mySpan)
                case "둘째날":
                    day = LocationDay.shared.secondDay
                    anno = day[0]
                    region = MKCoordinateRegion(center:anno.coordinate, span: vm.mySpan)
                case "셋째날":
                    day = LocationDay.shared.thirdDay
                    anno = day[0]
                    region = MKCoordinateRegion(center:anno.coordinate, span:vm.mySpan)
                case "넷째날":
                    day = LocationDay.shared.fourth
                    anno = day[0]
                    region = MKCoordinateRegion(center:anno.coordinate, span: vm.mySpan)
                default: break
                    
                }
            }
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct MapAnnotationItem:Identifiable{
    
    let id = UUID()
    let index:Int
    let image:String
    let placeName:String
    let coordinate:CLLocationCoordinate2D
    let location:String
    let naverLink:String
    let time:String
    
    
}

struct MyWebView: UIViewRepresentable {
   
    
    var urlToLoad: String
    
    //ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        //unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        //웹뷰 인스턴스 생성
        let webView = WKWebView()
        
        //웹뷰를 로드한다
        webView.load(URLRequest(url: url))
        return webView
    }
    
    //업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebView>) {
        
    }
}

class LocationDay{
    static let shared = LocationDay()
    
    let firstDay:[MapAnnotationItem] = [
        MapAnnotationItem(index: 1, image: "airplane",placeName: "제주공항", coordinate: CLLocationCoordinate2D(latitude: 33.509597, longitude: 126.491504),location: "제주특별자치도 제주시 공항로 2", naverLink: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%A0%9C%EC%A3%BC%EA%B3%B5%ED%95%AD", time: "약 20:35"),
        MapAnnotationItem(index: 2, image: "car.fill",placeName: "무지개렌트카",coordinate: CLLocationCoordinate2D(latitude: 33.496147, longitude: 126.4829198) ,location: "제주특별자치도 제주시 제성1길 28-1", naverLink: "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EB%AC%B4%EC%A7%80%EA%B0%9C%EB%A0%8C%ED%8A%B8%EC%B9%B4&oquery=%EC%A0%9C%EC%A3%BC%EA%B3%B5%ED%95%AD&tqi=i7sV%2FdprvxsssAcTf9KssssstVK-005725", time: "약 21:30"),
        MapAnnotationItem(index: 3, image: "building.fill", placeName: "골든데이지호텔", coordinate: CLLocationCoordinate2D(latitude: 33.249232, longitude: 126.567605), location: "제주특별자치도 서귀포시 특별자치도, 서귀동 동홍로 7 KR", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%EA%B3%A8%EB%93%A0%EB%8D%B0%EC%9D%B4%EC%A7%80+%EC%84%9C%EA%B7%80%ED%8F%AC&oquery=%EB%AC%B4%EC%A7%80%EA%B0%9C%EB%A0%8C%ED%8A%B8%EC%B9%B4&tqi=i7sXHsprvxsssAtfbZsssssssfN-429961&acq=%EA%B3%A8%EB%93%A0%EB%8D%B0%EC%9D%B4%EC%A7%80&acr=1&qdt=0", time: "약 22:30")
        
    ]
    let secondDay:[MapAnnotationItem] = [
    
        MapAnnotationItem(index: 1, image: "building.fill", placeName: "골든데이지호텔", coordinate: CLLocationCoordinate2D(latitude: 33.249232, longitude: 126.567605), location: "제주특별자치도 서귀포시 특별자치도, 서귀동 동홍로 7 KR", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%EA%B3%A8%EB%93%A0%EB%8D%B0%EC%9D%B4%EC%A7%80+%EC%84%9C%EA%B7%80%ED%8F%AC&oquery=%EB%AC%B4%EC%A7%80%EA%B0%9C%EB%A0%8C%ED%8A%B8%EC%B9%B4&tqi=i7sXHsprvxsssAtfbZsssssssfN-429961&acq=%EA%B3%A8%EB%93%A0%EB%8D%B0%EC%9D%B4%EC%A7%80&acr=1&qdt=0", time: "약 8:30"),
        MapAnnotationItem(index: 2, image: "flag.checkered", placeName: "테디베어뮤지엄", coordinate: CLLocationCoordinate2D(latitude: 33.250299, longitude: 126.412208), location: "제주특별자치도 서귀포시 특별자치도 중문관광로110번길 31", naverLink: "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%ED%85%8C%EB%94%94%EB%B2%A0%EC%96%B4%EB%AE%A4%EC%A7%80%EC%97%84&oquery=%EA%B3%A8%EB%93%A0%EB%8D%B0%EC%9D%B4%EC%A7%80+%EC%84%9C%EA%B7%80%ED%8F%AC&tqi=i7sYpdprvN8sstx8gvhssssssLo-455015", time: "약 9:00"),
        MapAnnotationItem(index: 3, image: "fork.knife", placeName: "먹돌 제주본점", coordinate: CLLocationCoordinate2D(latitude: 33.5019637, longitude: 126.5047973), location: "제주특별자치도 제주시 용담2동 월성로 26", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%EC%A0%9C%EC%A3%BC+%EB%A8%B9%EB%8F%8C&oquery=%ED%85%8C%EB%94%94%EB%B2%A0%EC%96%B4%EB%AE%A4%EC%A7%80%EC%97%84&tqi=i7uW2lprvmZssPmXpxVssssstjZ-425894&acq=%EC%A0%9C%EC%A3%BC%EB%A8%B9%EB%8F%8C&acr=1&qdt=0", time: "약 11:00"),
        MapAnnotationItem(index: 4, image: "flag.checkered", placeName: "D&DEPARTMENT JEJU by ARARIO", coordinate: CLLocationCoordinate2D(latitude: 33.517680, longitude: 126.523530), location: "제주특별자치도 제주시 특별자치도, 탑동로2길 3", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=d%26department&oquery=d%26d&tqi=i7uYilp0YiRssEwbvZhssssstEs-171993&acq=d%26d&acr=2&qdt=0", time: "약 12:15"),
        MapAnnotationItem(index: 5, image: "flag.checkered", placeName: "스위스마을", coordinate: CLLocationCoordinate2D(latitude: 33.494229, longitude: 126.676758), location: "제주특별자치도 제주시 조천읍 함와로 566-27", naverLink: "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EC%A0%9C%EC%A3%BC+%EC%8A%A4%EC%9C%84%EC%8A%A4%EB%A7%88%EC%9D%84&oquery=%EC%8A%A4%EC%9C%84%EC%8A%A4%EB%A7%88%EC%9D%84&tqi=i7v35lprvmsssNRA6ddssssssWC-173124", time: "약 13:50"),
        MapAnnotationItem(index: 6, image: "hare.fill", placeName: "도치돌알파카목장", coordinate: CLLocationCoordinate2D(latitude: 33.4099012, longitude: 126.3667667), location: "제주특별자치도 제주시 특별자치도 애월읍 납읍리 98-1", naverLink: "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EB%8F%84%EC%B9%98%EB%8F%8C%EC%95%8C%ED%8C%8C%EC%B9%B4%EB%AA%A9%EC%9E%A5&oquery=%EB%8F%84%EC%B9%98%EB%8F%8C&tqi=i7uxJlp0YidssLLCEGosssssscs-158692", time: "약 13:50"),
        MapAnnotationItem(index: 7, image: "cup.and.saucer.fill", placeName: "애월 카페거리", coordinate: CLLocationCoordinate2D(latitude: 33.4623497, longitude: 126.3103487), location: "제주특별자치도 제주시 애월읍 애월로1길", naverLink: "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EC%95%A0%EC%9B%94%EC%B9%B4%ED%8E%98%EA%B1%B0%EB%A6%AC&oquery=%EB%8F%84%EC%B9%98%EB%8F%8C%EC%95%8C%ED%8C%8C%EC%B9%B4%EB%AA%A9%EC%9E%A5&tqi=i7ux8lp0YiRssE84PHdssssssLs-444159", time: "약 13:50"),
        MapAnnotationItem(index: 8, image: "sailboat.fill", placeName: "청아투명카약", coordinate: CLLocationCoordinate2D(latitude: 33.4624, longitude: 126.3102867), location: "제주특별자치도 제주시 특별자치도, 애월로 11", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%EC%B2%AD%EC%95%84%EC%B9%B4%EC%95%BD&oquery=%EC%95%A0%EC%9B%94%EC%B9%B4%ED%8E%98%EA%B1%B0%EB%A6%AC&tqi=i7uyGdprvTVssKedE%2FlssssssxG-051465&acq=%EC%B2%AD%EC%95%84%EC%B9%B4%EC%95%BD&acr=1&qdt=0", time: "약 14:30"),
        MapAnnotationItem(index: 9, image: "flag.checkered", placeName: "제주갈치 한담", coordinate: CLLocationCoordinate2D(latitude: 33.46337263446717, longitude: 126.31008246910172), location: "제주 제주시 애월읍 애월로1길 24-11 제주갈치 한담", naverLink: "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EC%A0%9C%EC%A3%BC%EA%B0%88%EC%B9%98+%ED%95%9C%EB%8B%B4&oquery=%EC%A0%9C%EC%A3%BC%EA%B0%88%EC%B9%98&tqi=i7uzAlp0Yihssvza7Sdssssss9s-159695", time: "약 15:30"),
        MapAnnotationItem(index: 10, image: "cart", placeName: "수목원길 야시장", coordinate: CLLocationCoordinate2D(latitude: 33.4701345, longitude: 126.4881995), location: "제주특별자치도 제주시 특별자치도 은수길 69", naverLink: "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EC%88%98%EB%AA%A9%EC%9B%90%EA%B8%B8+%EC%95%BC%EC%8B%9C%EC%9E%A5&oquery=%EC%A0%9C%EC%A3%BC%EB%A8%B9%EB%8F%8C&tqi=i7u1vwprvTVssUbhhMdsssssso4-012171", time: "약 17:00"),
        MapAnnotationItem(index: 11, image: "cart", placeName: "서귀포 매일올레시장", coordinate: CLLocationCoordinate2D(latitude: 33.248679, longitude: 126.564143), location: "제주특별자치도 서귀포시 특별자치도 중앙로62번길 18", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%EC%84%9C%EA%B7%80%ED%8F%AC+%EC%98%AC%EB%A0%88%EC%8B%9C%EC%9E%A5&oquery=%EB%AA%A8%EB%A9%94%EB%93%A0+%EC%8B%9D%EB%8B%B9&tqi=i7vshlp0JXossvTvM7lssssstWh-458874&acq=%EC%84%9C%EA%B7%80%ED%8F%AC+%EC%98%AC%EB%A0%88&acr=1&qdt=0", time: "약 18:00")
        ]
    
    
    let thirdDay:[MapAnnotationItem] = [
        MapAnnotationItem(index: 1, image: "building.fill", placeName: "골든데이지호텔", coordinate: CLLocationCoordinate2D(latitude: 33.249232, longitude: 126.567605), location: "제주특별자치도 서귀포시 특별자치도, 서귀동 동홍로 7 KR", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%EA%B3%A8%EB%93%A0%EB%8D%B0%EC%9D%B4%EC%A7%80+%EC%84%9C%EA%B7%80%ED%8F%AC&oquery=%EB%AC%B4%EC%A7%80%EA%B0%9C%EB%A0%8C%ED%8A%B8%EC%B9%B4&tqi=i7sXHsprvxsssAtfbZsssssssfN-429961&acq=%EA%B3%A8%EB%93%A0%EB%8D%B0%EC%9D%B4%EC%A7%80&acr=1&qdt=0", time: "약 09:30"),
        MapAnnotationItem(index: 2, image: "flag.checkered", placeName: "윈드카드1947", coordinate: CLLocationCoordinate2D(latitude: 33.2890188, longitude: 126.5875565), location: "제주특별자치도 서귀포시 토평동 토평공단로 78-27", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%EC%9C%88%EB%93%9C%EC%B9%B4%ED%8A%B81947&oquery=%EC%88%98%EB%AA%A9%EC%9B%90%EA%B8%B8+%EC%95%BC%EC%8B%9C%EC%9E%A5&tqi=i7u34lp0JXVssmxJeCossssstTK-314493&acq=%EC%9C%88%EB%93%9C%EC%B9%B4%ED%8A%B8&acr=2&qdt=0", time: "약 09:45"),
        MapAnnotationItem(index: 3, image: "fork.knife", placeName: "함쉐프키친", coordinate: CLLocationCoordinate2D(latitude: 33.240739, longitude: 126.431200), location: "제주특별자치도 서귀포시 대포동 1807", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%ED%95%A8%EC%89%90%ED%94%84%ED%82%A4%EC%B9%9C&oquery=%EC%9C%88%EB%93%9C%EC%B9%B4%ED%8A%B81947&tqi=i7uIawp0J1ZssmWyr6Rsssssstd-145094&acq=%ED%95%A8%EC%89%90%ED%94%84%ED%82%A4%EC%B9%9C&acr=1&qdt=0", time: "약 11:00"),
        MapAnnotationItem(index: 4, image: "cup.and.saucer.fill", placeName: "휴일로 카페", coordinate: CLLocationCoordinate2D(latitude: 33.232376, longitude: 126.366216), location: "제주특별자치도 서귀포시 안덕면 난드르로 49-65", naverLink: "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%ED%9C%B4%EC%9D%BC%EB%A1%9C%EC%B9%B4%ED%8E%98&oquery=%ED%95%A8%EC%89%90%ED%94%84%ED%82%A4%EC%B9%9C&tqi=i7uI9dprvTVssUKmT%2BKssssssmd-304688", time: "약 12:30"),
        MapAnnotationItem(index: 5, image: "flag.checkered", placeName: "소인국 테마파크", coordinate: CLLocationCoordinate2D(latitude: 33.2906924, longitude: 126.322169), location: "제주특별자치도 서귀포시 특별자치도, 안덕면 중산간서로 1878 KR", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%EC%86%8C%EC%9D%B8%EA%B5%AD+%ED%85%8C%EB%A7%88%ED%8C%8C%ED%81%AC&oquery=%ED%9C%B4%EC%9D%BC%EB%A1%9C%EC%B9%B4%ED%8E%98&tqi=i7uJYsprvxssslOwinsssssssfV-401173&acq=%EC%86%8C%EC%9D%B8%EA%B5%AD&acr=1&qdt=0", time: "약 13:30"),
        MapAnnotationItem(index: 6, image: "flag.checkered", placeName: "무민랜드", coordinate: CLLocationCoordinate2D(latitude: 33.30701, longitude: 126.3820054), location: "제주특별자치도 서귀포시 안덕면", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%EB%AC%B4%EB%AF%BC%EB%9E%9C%EB%93%9C+%EC%A0%9C%EC%A3%BC&oquery=%EC%86%8C%EC%9D%B8%EA%B5%AD+%ED%85%8C%EB%A7%88%ED%8C%8C%ED%81%AC&tqi=i7u9Wwp0JXVssm3pyDossssssaN-057306&acq=%EB%AC%B4%EB%AF%BC%EB%9E%9C%EB%93%9C&acr=1&qdt=0", time: "약 15:00"),
        MapAnnotationItem(index: 7, image: "fork.knife", placeName: "모메든 식당", coordinate: CLLocationCoordinate2D(latitude: 33.253417, longitude: 126.454666), location: "제주특별자치도 서귀포시 특별자치도, 하원동 1381-1 KR", naverLink: "https://search.naver.com/search.naver?sm=tab_sug.top&where=nexearch&query=%EB%AA%A8%EB%A9%94%EB%93%A0+%EC%8B%9D%EB%8B%B9&oquery=%EB%AC%B4%EB%AF%BC%EB%9E%9C%EB%93%9C+%EC%A0%9C%EC%A3%BC&tqi=i7u%2F5wprvmZsstQIibCssssss4C-495767&acq=%EB%AA%A8%EB%A9%94%EB%93%A0&acr=1&qdt=0", time: "약 16:30"),
        MapAnnotationItem(index: 8, image: "building.fill", placeName: "제주 풍경호텔", coordinate: CLLocationCoordinate2D(latitude: 33.244895, longitude: 126.553437), location: "제주특별자치도 서귀포시 특별자치도, 남성중로 147 KR", naverLink: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%A0%9C%EC%A3%BC+%ED%92%8D%EA%B2%BD%ED%98%B8%ED%85%94", time: "일정 끝")
    
    ]
        
    let fourth:[MapAnnotationItem] = [

        
        MapAnnotationItem(index: 8, image: "building.fill", placeName: "제주 풍경호텔", coordinate: CLLocationCoordinate2D(latitude: 33.244895, longitude: 126.553437), location: "제주특별자치도 서귀포시 특별자치도, 남성중로 147 KR", naverLink: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%A0%9C%EC%A3%BC+%ED%92%8D%EA%B2%BD%ED%98%B8%ED%85%94", time: "약 07:30"),
        MapAnnotationItem(index: 2, image: "car.fill",placeName: "무지개렌트카",coordinate: CLLocationCoordinate2D(latitude: 33.496147, longitude: 126.4829198) ,location: "제주특별자치도 제주시 제성1길 28-1", naverLink: "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EB%AC%B4%EC%A7%80%EA%B0%9C%EB%A0%8C%ED%8A%B8%EC%B9%B4&oquery=%EC%A0%9C%EC%A3%BC%EA%B3%B5%ED%95%AD&tqi=i7sV%2FdprvxsssAcTf9KssssstVK-005725", time: "약 08:30"),
        MapAnnotationItem(index: 3, image: "airplane",placeName: "제주공항", coordinate: CLLocationCoordinate2D(latitude: 33.509597, longitude: 126.491504),location: "제주특별자치도 제주시 공항로 2", naverLink: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%A0%9C%EC%A3%BC%EA%B3%B5%ED%95%AD", time: "약 08:45")
    ]
}
