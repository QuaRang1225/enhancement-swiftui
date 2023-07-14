//
//  Location.swift
//  EX_Location
//
//  Created by 유영웅 on 2022/12/28.
//

import Foundation
import CoreLocation
import MapKit

final class Location:NSObject,ObservableObject,CLLocationManagerDelegate{
    @Published var region = MKCoordinateRegion()
    
    let locationManger = CLLocationManager()
    override init(){
        super.init()
        locationManger.delegate = self
        requestLocation()
    }
    func requestLocation()
    {
        locationManger.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {return}
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
