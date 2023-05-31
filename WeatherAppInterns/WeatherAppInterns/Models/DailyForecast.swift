
//  DailyForecast.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 23/05/23.
//

import Foundation
//Struct DailyForecast
struct DailyForecast: Decodable {
  struct Daily: Decodable {
    let dt: Double
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Double
    let wind_gust: Double
    let pop: Double
    let uvi: Double
    struct temp: Decodable {
      let day: Double
      let min: Double
      let max: Double
      let night: Double
      enum CodingKeys: String, CodingKey {
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
      }
    }
    struct weather: Codable {
      let id: Double
      let main: String
      let description: String
    }
    let weather: [weather]
    let temp: temp
  }
  let daily: [Daily]
}
extension DailyForecast {
  static var mock: Self {
    .init(daily: [Daily(dt: 0, pressure: 0, humidity: 0, dew_point: 0, wind_speed: 0, wind_deg: 0, wind_gust: 0, pop: 0, uvi: 0, weather: [Daily.weather(id: 0, main: "0", description: "0")], temp: Daily.temp(day: 0, min: 0, max: 0, night: 0))])
  }
}

