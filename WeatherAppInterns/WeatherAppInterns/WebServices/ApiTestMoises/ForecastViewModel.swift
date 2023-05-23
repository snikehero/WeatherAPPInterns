//
//  ForecastViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 22/05/23.
//

import Foundation

struct ForecastViewModel {
  let forecast: Forecast.List

  private static var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, d, HH:mm"
    return dateFormatter
  }
  
  private static var numberFormatter: NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.maximumFractionDigits = 0
    return numberFormatter
  }
  
  private static var numberFormatterDecimal: NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .percent
    return numberFormatter
  }
  var day: String {
    return Self.dateFormatter.string(from: forecast.dt)
  }
  var overview: String {
    forecast.weather.description.capitalized
  }
 var high: String {
   return "H: \(Self.numberFormatter.string(for: forecast.main.temp_max) ?? "0")Grados "
  }
  var low: String {
    return "L: \(Self.numberFormatter.string(for: forecast.main.temp_min) ?? "0")Grados "
   }
  var fellsLike: String {
    return "Feels: \(Self.numberFormatter.string(for: forecast.main.feels_like) ?? "0") Grados"
  }
  var pressure: String {
    return "Pressure: \(Self.numberFormatter.string(for: forecast.main.pressure) ?? "0" ) Pascal"
  }
  var humidity: String {
    return "Humidity \(forecast.main.humidity)%"
  }
  var weatherDescription: String {
    return "Descripcion: \(forecast.weather[0].description)"
  }
  var clouds: String {
    return "Clouds: \(forecast.clouds.all)"
  }
  var windSpeed: String {
    return "WindSpeed: \(forecast.wind.speed)"
  }
  var windDeg: String {
    return "WindDeg: \(forecast.wind.deg)"
  }
  var windGust: String {
    return "WindGust: \(forecast.wind.gust)"
  }
  var visibility: String {
    return "Visibility: \(forecast.visibility)"
  }
  var precipitation: String {
    return "Precipitation: \(forecast.pop)"
  }

}
