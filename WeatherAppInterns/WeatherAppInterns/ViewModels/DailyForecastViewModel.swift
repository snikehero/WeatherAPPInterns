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
    return "\(Self.numberFormatter.string(for: dailyForecast.temp.max) ?? "0")°"
  }
  var minTemp: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.temp.min) ?? "0")°"
  }
  var uvi: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.uvi) ?? "0")"
    //return "\(dailyForecast.uvi)"
  }
//  let pressure: Double
//  let humidity: Double
//  let dew_point: Double
//  let wind_speed: Double
//  let wind_deg: Double
//  let wind_gust: Double
//  let pop: Double
//  let uvi: Double
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
    .init(dailyForecast: DailyForecast.Daily(dt: 0, pressure: 0, humidity: 0, dew_point: 0, wind_speed: 0, wind_deg: 0, wind_gust: 0, pop: 0, uvi: 0, weather: [DailyForecast.Daily.weather(id: 0, main: "", description: "")], temp: DailyForecast.Daily.temp(min: 0, max: 0, day: 0)))
  }
}
