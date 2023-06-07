//
//  ForecastViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 22/05/23.
//

import Foundation

struct ForecastViewModel {
  let forecast: Forecast.List
  var system: Int
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
  private static var dateFormatterHourDay: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH"
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
  func convert(_ temp: Double) -> Double {
    let celsius = temp
    if system == 0 {
      return celsius
      
    } else {
      return celsius * 9 / 5 + 32
    }
  }
  var dayNumber: String {
    return "\(Self.dateFormatterDayNumber.string(from: NSDate(timeIntervalSince1970: forecast.dt) as Date))"
  }
  var exactDayName: String {
    return "\(Self.dateFormatterDay.string(from: NSDate(timeIntervalSince1970: forecast.dt )as Date))"
  }
  var hourDay: String {
    return "\(Self.dateFormatterHourDay.string(from: NSDate(timeIntervalSince1970: forecast.dt) as Date))"
  }
  var day: String {
    return "\(Self.dateFormatterDayNumber.string(from: NSDate(timeIntervalSince1970: forecast.dt) as Date))"  }
  var overview: String {
    forecast.weather[0].description.capitalized
  }
  var current: String {
    return "\(Self.numberFormatter.string(for: convert(forecast.main.temp)) ?? "0" )"
  }
  var high: String {
    return "\(Self.numberFormatter.string(for: convert(forecast.main.temp_max)) ?? "0")"
  }
  var low: String {
    return "\(Self.numberFormatter.string(for: convert(forecast.main.temp_min)) ?? "0")"
   }
  var fellsLike: String {
    return "\(Self.numberFormatter.string(for: convert(forecast.main.feels_like)) ?? "0")"
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
  var emoji: String {
    switch forecast.weather.first?.main {
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
      switch forecast.weather.first?.description {
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
extension ForecastViewModel {
    static var mock: Self {
      .init(forecast: Forecast.List(dt: 0, main: Forecast.List.Main(temp: 0, feels_like: 0, temp_min: 0, temp_max: 0, pressure: 0, sea_level: 0, grnd_level: 0, humidity: 0), weather: [Forecast.List.Weather(id: 0, main: "", description: "", icon: "")], clouds: Forecast.List.Clouds(all: 0), wind: Forecast.List.Wind(speed: 0, deg: 0, gust: 0), pop: 0, visibility: 0), system: 0)
  }
  static var mock1: Self {
    .init(forecast: Forecast.List(dt: 0, main: Forecast.List.Main(temp: 43, feels_like: 10, temp_min: 5, temp_max: 60, pressure: 999, sea_level: 65, grnd_level: 64, humidity: 20), weather: [Forecast.List.Weather(id: 0, main: "Thunderstorm", description: "Clouds", icon: "")], clouds: Forecast.List.Clouds(all: 100), wind: Forecast.List.Wind(speed: 35, deg: 90, gust: 43), pop: 0.1, visibility: 200), system: 0)
  }
  static var mock2: Self {
    .init(forecast: Forecast.List(dt: 0, main: Forecast.List.Main(temp: 10, feels_like: 5, temp_min: 0, temp_max: 10, pressure: 1020, sea_level: 65, grnd_level: 64, humidity: 50), weather: [Forecast.List.Weather(id: 0, main: "Tornado", description: "Clouds", icon: "")], clouds: Forecast.List.Clouds(all: 20), wind: Forecast.List.Wind(speed: 70, deg: 30, gust: 30), pop: 0.3, visibility: 10), system: 0)
  }
  static var mock3: Self {
    .init(forecast: Forecast.List(dt: 0, main: Forecast.List.Main(temp: 35, feels_like: 35, temp_min: 1, temp_max: 10, pressure: 1010, sea_level: 65, grnd_level: 64, humidity: 35), weather: [Forecast.List.Weather(id: 0, main: "Rain", description: "Clouds", icon: "")], clouds: Forecast.List.Clouds(all: 10), wind: Forecast.List.Wind(speed: 45, deg: 110, gust: 40), pop: 0.4, visibility: 100), system: 0)
  }
  static var mock4: Self {
    .init(forecast: Forecast.List(dt: 0, main: Forecast.List.Main(temp: 25, feels_like: 20, temp_min: 20, temp_max: 35, pressure: 999, sea_level: 65, grnd_level: 64, humidity: 45), weather: [Forecast.List.Weather(id: 0, main: "Snow", description: "Clouds", icon: "")], clouds: Forecast.List.Clouds(all: 30), wind: Forecast.List.Wind(speed: 35, deg: 90, gust: 43), pop: 0.1, visibility: 200), system: 0)
  }
  static var mock5: Self {
    .init(forecast: Forecast.List(dt: 0, main: Forecast.List.Main(temp: 43, feels_like: 10, temp_min: 5, temp_max: 60, pressure: 999, sea_level: 65, grnd_level: 64, humidity: 20), weather: [Forecast.List.Weather(id: 0, main: "Clouds", description: "few clouds", icon: "")], clouds: Forecast.List.Clouds(all: 100), wind: Forecast.List.Wind(speed: 55, deg: 20, gust: 50), pop: 0.5, visibility: 250), system: 0)
  }
  static var mock6: Self {
    .init(forecast: Forecast.List(dt: 0, main: Forecast.List.Main(temp: 35, feels_like: 200, temp_min: 20, temp_max: 40, pressure: 999, sea_level: 65, grnd_level: 64, humidity: 90), weather: [Forecast.List.Weather(id: 0, main: "Clouds", description: "overcast clouds", icon: "")], clouds: Forecast.List.Clouds(all: 100), wind: Forecast.List.Wind(speed: 65, deg: 270, gust: 79), pop: 0.6, visibility: 1000), system: 0)
  }
  static var mock7: Self {
    .init(forecast: Forecast.List(dt: 0, main: Forecast.List.Main(temp: 60, feels_like: 1000, temp_min: -5, temp_max: 30, pressure: 999, sea_level: 65, grnd_level: 64, humidity: 100), weather: [Forecast.List.Weather(id: 0, main: "Mist", description: "Clouds", icon: "")], clouds: Forecast.List.Clouds(all: 1000), wind: Forecast.List.Wind(speed: 90, deg: 0, gust: 39), pop: 0.7, visibility: 3000), system: 0)
  }
  
}
