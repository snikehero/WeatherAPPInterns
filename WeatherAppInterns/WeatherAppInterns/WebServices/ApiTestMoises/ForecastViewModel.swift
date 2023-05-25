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
    return "\(Self.dateFormatter.string(from: NSDate(timeIntervalSince1970: forecast.dt) as Date))"  }
  var overview: String {
    forecast.weather[0].description.capitalized
  }
  var current: String {
    return "\(Self.numberFormatter.string(for: forecast.main.temp) ?? "0" )"
  }
 var high: String {
   return "\(Self.numberFormatter.string(for: forecast.main.temp_max) ?? "0")"
  }
  var low: String {
    return "\(Self.numberFormatter.string(for: forecast.main.temp_min) ?? "0")"
   }
  var fellsLike: String {
    return "\(Self.numberFormatter.string(for: forecast.main.feels_like) ?? "0")"
  }
  var pressure: String {
    return "\(Self.numberFormatter.string(for: forecast.main.pressure) ?? "0")"
  }
  var visibility: String {
    return "\(Self.numberFormatter.string(for: forecast.visibility / 1000) ?? "0")"
  }
  var humidity: String {
    return "\(forecast.main.humidity)"
  }
  var weatherDescription: String {
    return "\(forecast.weather[0].description)"
  }
  var clouds: String {
    return "\(forecast.clouds.all)"
  }
  var windSpeed: String {
    return "\(forecast.wind.speed)"
  }
  var windDeg: String {
    return "\(forecast.wind.deg)"
  }
  var windGust: String {
    return "\(forecast.wind.gust)"
  }
  var precipitation: String {
    return "\(forecast.pop)"
  }
  var weatherIconURL: URL {
    let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
    return URL(string: urlString)!
  }
   
  var visibilityDescription: String {
    if forecast.visibility >= 10{
      return "Clear"
    }
    else
    {
      return "Not Clear"
    }
  }
  var id: UUID {
    return UUID()
  }

}
