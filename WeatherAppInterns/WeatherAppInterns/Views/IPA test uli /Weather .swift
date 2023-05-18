//
//  Weather .swift
//  WeatherAppInterns
//
//  Created by Ulises Burns on 17/05/23.
//

import Foundation

public struct Weather {
  let city: String
  let temperature: String
  let description: String
  let iconName: String
  let tempMin: String
  let tempMax: String
  let pressure: String
  let humidity: String
  let windSpeed: Double
  
  init(response: APIResponse) {
    city = response.name
    temperature = "\(Double(response.main.temp))"
    tempMin = "\(Double(response.main.tempMin))"
    tempMax = "\(Double(response.main.tempMax))"
    pressure = "\(Int(response.main.pressure))"
    humidity = "\(Int(response.main.humidity))"
    description = response.weather.first?.description ?? ""
    iconName = response.weather.first?.iconName ?? ""
    windSpeed = response.wind.speed
    
  }
  
}
//public struct List {
//  //let weather: Weather
//  let city: String
//  let weatherData: Weather
//  init(response: WeatherList)
//  {
//    //weather = response.list
//    city = response.city.name
//    weatherData = respon
//  }
//}
