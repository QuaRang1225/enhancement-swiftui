//
//  ContentView.swift
//  EX_SavedLocation
//
//  Created by 유영웅 on 2023/02/16.
//

import SwiftUI
import CoreLocation
import MapKit


class B:NSObject,ObservableObject,CLLocationManagerDelegate{
    
    @Published var distance = 0.0
    var locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 이동 거리 계산
        if let location = locations.last {
            distance += location.distance(from: CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        }
    }
}

struct ContentView: View {
    
    
    var body: some View {
        VStack {
            Text("Distance: \(String(format: "%.2f", distance)) meters")
            
            Button(action: {
                // 위치 권한 요청
                locationManager.requestWhenInUseAuthorization()
                
                // 위치 업데이트 시작
                locationManager.startUpdatingLocation()
            }, label: {
                Text("Start")
            })
            .padding()
            
            Button(action: {
                // 위치 업데이트 중지
                locationManager.stopUpdatingLocation()
                
                // 이동 거리 저장
                saveDistance(distance)
            }, label: {
                Text("Stop")
            })
            .padding()
        }
        .onAppear {
            // 위치 관리자 설정
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    // 이동 거리 저장 함수
    func saveDistance(_ distance: Double) {
        // 현재 날짜 기준으로 저장할 파일 이름 생성
        let fileName = "\(Date().timeIntervalSince1970).txt"
        
        // 이동 거리를 파일로 저장
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(fileName)
            try "\(distance)".write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error saving distance: \(error)")
        }
    }
}

// 위치 관리자 델리게이트 설정

//struct ContentView: View {
//    @StateObject var vm = B()
//    @SceneStorage("locationRecord") var isButtonClick = true
//
//    var body: some View{
//        ZStack{
//            if vm.boolValue{
//                Text("참")
//            }else{
//                Text("거짓")
//            }
//        }
//        .onAppear{
//            vm.boolValue = $isButtonClick.wrappedValue
//        }
//    }
////    let locationManager = CLLocationManager()
////    var timer: Timer?
////    @State private var annotations: [MKPointAnnotation] = []
////
////    var body: some View {
////        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))), annotationItems: annotations) { annotation in
////            MapPin(coordinate: annotation.coordinate)
////        }
////        .onAppear {
////            self.requestLocation()
////            self.startTimer()
////        }
////        .onDisappear {
////            self.stopTimer()
////        }
////    }
////
////    func requestLocation() {
////        locationManager.requestAlwaysAuthorization()
////        locationManager.delegate = self
////        locationManager.allowsBackgroundLocationUpdates = true
////        locationManager.desiredAccuracy = kCLLocationAccuracyBest
////        locationManager.startUpdatingLocation()
////    }
////
////    func addAnnotation(_ location: CLLocation) {
////        let annotation = MKPointAnnotation()
////        annotation.coordinate = location.coordinate
////        self.annotations.append(annotation)
////    }
////
////    func saveAnnotations() {
////        let fileManager = FileManager.default
////        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
////        let annotationFileURL = documentDirectory.appendingPathComponent("annotations.txt")
////
////        var annotationStrings: [String] = []
////        for annotation in annotations {
////            let annotationString = "\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
////            annotationStrings.append(annotationString)
////        }
////
////        let annotationsString = annotationStrings.joined(separator: "\n")
////        do {
////            try annotationsString.write(to: annotationFileURL, atomically: true, encoding: .utf8)
////            print("Annotation 저장 완료")
////        } catch {
////            print("Annotation 저장 실패: \(error)")
////        }
////    }
////
////    func startTimer() {
////        let calendar = Calendar.current
////        let now = Date()
////        let date = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now)!
////        let secondsUntilMidnight = calendar.dateComponents([.second], from: now, to: date.addingTimeInterval(24 * 60 * 60)).second!
////        let interval = TimeInterval(secondsUntilMidnight)
////
////        self.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
////            self.saveAnnotations()
////        }
////    }
////
////    func stopTimer() {
////        self.timer?.invalidate()
////        self.timer = nil
////    }
//}

//extension ContentView: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        for location in locations {
//            self.addAnnotation(location)
//        }
//    }
//}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
