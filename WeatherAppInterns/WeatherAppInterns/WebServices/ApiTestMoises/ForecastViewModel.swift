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
  private static var dateFormatterDay: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter
  }
  private static var dateFormatterDayNumber: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d"
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
  var dayNumber: String {
    return "\(Self.dateFormatterDayNumber.string(from: NSDate(timeIntervalSince1970: forecast.dt) as Date))"
  }
  var exactDayName: String {
    return "\(Self.dateFormatterDay.string(from: NSDate(timeIntervalSince1970: forecast.dt )as Date))"
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
    return "\(Self.numberFormatterDecimal.string(for:forecast.pop) ?? "0")"
    //return "\(forecast.pop  )"
  }
  var weatherIconURL: URL {
    let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
    return URL(string: urlString)!
  }
  var popDescription: String {
    switch forecast.pop {
    case 0.10...0.20:
      return "Isolated"
    case 0.21...0.30:
      return "Slight Chance"
    case 0.31...0.50:
      return "Chance of rain"
    case 0.51...0.70:
      return "Likely chance of rain"
    case 0.71...1.0:
      return "High chance of rain"
    default:
      return "normal chance of rain"
    }
  }
  var visibilityDescription: String {
    switch forecast.visibility {
    case 0...200:
      return "Thick fog"
    case 201...500:
      return "Moderate fog"
    case 501...1000:
      return "Light fig"
    case 1001...2000:
      return "Thin fog"
    case 2001...4000:
      return "Haze"
    case 4001...5000:
      return "Light Haze"
    case 5001...7000:
      return "Clear"
    case 7001...20000:
      return "Very Clear"
    default:
      return "normal"
    }
  }
  var feelsLikeDescription: String {
    if forecast.main.temp < forecast.main.feels_like {
      return "The temperature feels hotter than normal"
    }
    else if forecast.main.temp > forecast.main.feels_like {
      return "The temperature feels colder than normal"
    }
    return "normal"
  }
  var id: UUID {
    return UUID()
  }
  var pressureDescription: String {
    switch forecast.main.pressure {
    case 0...1000:
      return "Low Pressure"
    case 1001...1020:
      return "Steady Pressure"
    case 1021...2000:
      return "High Pressure"
    default:
      return "Normal pressure"
    }
  }
  
}
