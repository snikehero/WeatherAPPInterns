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
  @Published var weatherDescription: String = "--"
  @Published var weatherIcon: String = defaultIcon
  
  public let weatherService: WeatherService
  
  init(weatherService: WeatherService) {
    self.weatherService = weatherService
  }


  func refresh() {
    weatherService.loadWeatherData { weather in
      DispatchQueue.main.async{
        self.cityname = weather.city
        self.temperature = "\(weather.temperature)°C"
        self.weatherDescription = weather.description.capitalized
        self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
      }
    }
  }
}
