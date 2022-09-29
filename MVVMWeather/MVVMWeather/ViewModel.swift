//
//  ViewModel.swift
//  MVVMWeather
//
//  Created by 유영웅 on 2022/09/19.
//

import Foundation

class WeatherViewModel:ObservableObject{
     
    private let iconImage = [
        "clear sky" : "☀️",
        "few clouds" : "🌤",
        "overcast clouds" : "☁",
        "scattered clouds" : "☁",
        "broken clouds" : "☁",
        "shower rain" : "🌧",
        "rain" : "🌦",
        "thunderstorm" : "🌩",
        "snow" : "❄",
        "mist" : "🌫️"
    ]
    
    @Published var title:String = "_"
    @Published var descript:String = "_"
    @Published var temp:String = "_"
    @Published var name:String = "_"
    @Published var icon:String = "_"
    
    init(){
        fetchWeather()
    }
    func fetchWeather(){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=36.3333&lon=127.4167&appid=839391d522b9f7b0d7b56a4219854a6d") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, _,error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let model = try JSONDecoder().decode(MainWeatherInfo.self, from: data)

                DispatchQueue.main.async {
                    self.title = model.weather.first?.main ?? "No title"
                    self.descript = model.weather.first?.description ?? "No descript"
                    self.icon = self.iconImage[self.descript] ?? "No Icon"
                    self.temp = String(format: "%.1f°C", model.main.temp - 273)
                    self.name = model.name
                }
            }
            catch{
                print("실패!")
            }
        }
        task.resume()
    }
}
