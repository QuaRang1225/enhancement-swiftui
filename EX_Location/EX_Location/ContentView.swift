//
//  ContentView.swift
//  EX_Location
//
//  Created by 유영웅 on 2022/12/28.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct ContentView: View {
    @StateObject var vm = Location()
    var body: some View {
        ZStack(alignment: .bottom){
            Map(coordinateRegion: $vm.region, showsUserLocation: true).ignoresSafeArea()
            LocationButton(.currentLocation){
                vm.requestLocation()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
