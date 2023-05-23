//
//  WeatherViewModel.swift
//  WeatherAppInterns
//
//  Created by Ulises Burns on 17/05/23.
//

import Foundation

private let defaultIcon = "⁉️"
private let iconMap = [
  "Drizzle" : "🌧️",
  "Thunderstorm" : "⛈️",
  "Rain": "🌧️",
  "Snow" : "❄️",
  "Clear" : "☀️",
  "Clouds" : "☁️",
]

class WeatherViewModel: ObservableObject {
  @Published var cityname: String = "City Name"
  @Published var temperature: String = "--"
  @Published var tempMin: String = ""
  @Published var tempMax: String = ""
  @Published var pressure: String = ""
  @Published var humidity: String = ""
  @Published var weatherDescription: String = "--"
  @Published var weatherIcon: String = defaultIcon
  @Published var windSpeed: Double = 0.0
  public let weatherService: WeatherService
  
  init(weatherService: WeatherService) {
    self.weatherService = weatherService
  }


  func refresh() {
    weatherService.loadWeatherData { weather in
      DispatchQueue.main.async{
        self.cityname = "\(weather.city)"
        self.temperature = "\(weather.temperature)°C"
        self.tempMin = "\(weather.tempMin)°C"
        self.tempMax = "\(weather.tempMax)°C"
        self.pressure = "\(weather.pressure)"
        self.humidity = "\(weather.humidity)"
        self.weatherDescription = weather.description.capitalized
        self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
        self.windSpeed = weather.windSpeed
        //self.clouds = weather.clouds
        //self.windSpeed = weather.windSpeed
      }
      
    }
//    weatherService.loadWeatherData2 { list in
//      DispatchQueue.main.async{
//        self.cityname = list.city
//      
//      }
//    }
  }
  
}
