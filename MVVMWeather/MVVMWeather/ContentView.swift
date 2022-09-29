//
//  ContentView.swift
//  MVVMWeather
//
//  Created by 유영웅 on 2022/09/19.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        
        NavigationView{
            VStack{
                Text(viewModel.icon).font(.system(size: 100)).padding()
                Text(viewModel.name).font(.system(size: 32))
                Text(viewModel.temp).font(.system(size: 44))
                Text(viewModel.title).font(.system(size: 24))
                Text(viewModel.descript).font(.system(size: 24))

            }.navigationTitle("MVVM Weather")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
