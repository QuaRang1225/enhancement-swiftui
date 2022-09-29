//
//  Model.swift
//  MVVMWeather
//
//  Created by 유영웅 on 2022/09/19.
//

import Foundation


struct MainWeather:Codable{
    let temp : Float
}
struct WeatherState:Codable{
    let description : String
    let main : String
    let icon : String
}
struct MainWeatherInfo : Codable{
    let main : MainWeather
    let weather : [WeatherState]
    let name : String
}


