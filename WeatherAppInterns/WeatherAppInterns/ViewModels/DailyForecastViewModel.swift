//
//  DailyForecastViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 23/05/23.
//

import Foundation


struct DailyForecastViewModel {
  let dailyForecast: DailyForecast.Daily
  private static var dateFormatterDayNumber: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d"
    return dateFormatter
  }
  private static var dateFormatterDay: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E"
    return dateFormatter
  }
  private static var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
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
  var id: UUID {
    return UUID()
  }
  var exactDayName: String {
    return "\(Self.dateFormatterDay.string(from: NSDate(timeIntervalSince1970: dailyForecast.dt )as Date))"
  }
  var dayNumber: String {
    return "\(Self.dateFormatterDayNumber.string(from: NSDate(timeIntervalSince1970: dailyForecast.dt) as Date))"
  }
  var day: String {
    //return Self.dateFormatter.string(from: NSDate(timeIntervalSince1970:(dailyForecast.dt) as Date)
    return "\(Self.dateFormatter.string(from: NSDate(timeIntervalSince1970: dailyForecast.dt) as Date))"
    // b(dataFormatter2.string(from: NSDate(timeIntervalSince1970: (forecast?.city.sunset)!) as Date))
  }
  var maxTemp: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.temp.max) ?? "0")"
  }
  var current: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.temp.day) ?? "0")"
  }
  var minTemp: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.temp.min) ?? "0")"
  }
  var uvi: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.uvi) ?? "0")"
    //return "\(dailyForecast.uvi)"
  }
  var humidity: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.humidity) ?? "0")"
  }
  var dew_point: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.dew_point) ?? "0")"
  }
  var pressure: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.pressure) ?? "0")"
  }
  var windSpeed: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.wind_speed) ?? "0")"
  }
  var windDeg: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.wind_deg) ?? "0")"
  }
  var windGust: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.wind_gust) ?? "0")"
  }
  var pop: String {
    return "\(Self.numberFormatterDecimal.string(for: dailyForecast.pop ) ?? "0")"
  }
  var subtitle: String {
    switch dailyForecast.uvi.rounded() {
    case 0...2:
      return "Low"
    case 3...5:
      return "Moderate"
    case 6...7:
      return "High"
    case 8...10:
      return "Very High"
    case 11...20:
      return "Extreme"
    default:
      return "Normal"
    }
  }
  var description: String {
    switch dailyForecast.uvi.rounded() {
    case 0...2:
      return "Wear sunglasses on bright days."
    case 3...5:
      return "Stay in shade near midday"
    case 6...7:
      return "Reduce time in the sun."
    case 8...10:
      return "Minimize sun exposure"
    case 11...20:
      return "Try to avoid sun exposure"
    default:
      return "Normal"
    }
  }
  var emoji: String {
    switch dailyForecast.weather.first?.main {
    case "Thunderstorm":
      return ("⛈️")
    case "Drizzle":
      return ("🌧️")
    case "Rain":
      return ("☔️")
    case "Snow":
      return ("☃️")
    case "Mist":
      return ("🌫️")
    case "Smoke":
      return ("🌫️")
    case "Haze":
      return ("🌫️")
    case "Dust":
      return ("🌫️")
    case "Fog":
      return ("🌫️")
    case "Sand":
      return ("🌫️")
    case "Ash":
      return ("🌫️")
    case "Squall":
      return ("🌫️")
    case "Tornado":
      return ("🌪️")
    case "Clear":
      return ("☀️")
    case "Clouds":
      switch dailyForecast.weather.first?.description {
      case "few clouds":
        return "🌤️"
      case "scattered clouds":
        return "☁️"
      case "broken clouds":
        return "☁️"
      case "overcast clouds":
        return "☁️"
      default:
        return "❌"
      }
    default:
      return "❌"
      
    }
    }
  
}
extension DailyForecastViewModel {
  static var mock: Self {
    .init(dailyForecast: DailyForecast.Daily(dt: 0, pressure: 0, humidity: 0, dew_point: 0, wind_speed: 0, wind_deg: 0, wind_gust: 0, pop: 0, uvi: 0, weather: [DailyForecast.Daily.weather(id: 0, main: "", description: "")], temp: DailyForecast.Daily.temp(day: 0, min: 0, max: 0, night: 0)))
  }
  static var mock1: Self {
    .init(dailyForecast: DailyForecast.Daily(dt: 0, pressure: 999, humidity: 20, dew_point: 90, wind_speed: 35, wind_deg: 90, wind_gust: 43, pop: 0.1, uvi: 10, weather: [DailyForecast.Daily.weather(id: 0, main: "Thunderstorm", description: "Thunderstorm")], temp: DailyForecast.Daily.temp(day: 0, min: 5, max: 60, night: 0)))
  }
  static var mock2: Self {
    .init(dailyForecast: DailyForecast.Daily(dt: 0, pressure: 1020, humidity: 50, dew_point: 10, wind_speed: 70, wind_deg: 30, wind_gust: 30, pop: 0.3, uvi: 3, weather: [DailyForecast.Daily.weather(id: 0, main: "Tornado", description: "Thunderstorm")], temp: DailyForecast.Daily.temp(day: 0, min: 0, max: 10, night: 0)))
  }

  static var mock3: Self {
    .init(dailyForecast: DailyForecast.Daily(dt: 0, pressure: 1010, humidity: 35, dew_point: 40, wind_speed: 45, wind_deg: 110, wind_gust: 40, pop: 0.4, uvi: 2, weather: [DailyForecast.Daily.weather(id: 0, main: "Rain", description: "Thunderstorm")], temp: DailyForecast.Daily.temp(day: 0, min: 1, max: 10, night: 0)))
  }
  static var mock4: Self {
    .init(dailyForecast: DailyForecast.Daily(dt: 0, pressure: 999, humidity: 20, dew_point: 90, wind_speed: 35, wind_deg: 90, wind_gust: 43, pop: 0.1, uvi: 10, weather: [DailyForecast.Daily.weather(id: 0, main: "Snow", description: "Thunderstorm")], temp: DailyForecast.Daily.temp(day: 0, min: 5, max: 60, night: 0)))
  }
  
  static var mock5: Self {
    .init(dailyForecast: DailyForecast.Daily(dt: 0, pressure: 999, humidity: 20, dew_point: 10, wind_speed: 55, wind_deg: 20, wind_gust: 50, pop: 0.5, uvi: 3, weather: [DailyForecast.Daily.weather(id: 0, main: "Clouds", description: "few clouds")], temp: DailyForecast.Daily.temp(day: 0, min: 20, max: 25, night: 0)))
  }

  static var mock6: Self {
    .init(dailyForecast: DailyForecast.Daily(dt: 0, pressure: 999, humidity: 90, dew_point: 90, wind_speed: 65, wind_deg: 27, wind_gust: 79, pop: 0.6, uvi: 4, weather: [DailyForecast.Daily.weather(id: 0, main: "Thunderstorm", description: "overcast clouds")], temp: DailyForecast.Daily.temp(day: 0, min: 20, max: 40, night: 0)))
  }
  
  static var mock7: Self {
    .init(dailyForecast: DailyForecast.Daily(dt: 0, pressure: 999, humidity: 100, dew_point: 90, wind_speed: 90, wind_deg: 0, wind_gust: 39, pop: 0.7, uvi: 8, weather: [DailyForecast.Daily.weather(id: 0, main: "Mist", description: "Thunderstorm")], temp: DailyForecast.Daily.temp(day: 0, min: -5, max: 30, night: 0)))
  }
  
}
