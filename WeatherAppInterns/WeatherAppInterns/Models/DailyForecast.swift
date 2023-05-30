
//  DailyForecast.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 23/05/23.
//

import Foundation
//Struct DailyForecast
struct DailyForecast: Decodable {
  struct Daily: Codable {
    let dt: Double
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Double
    let wind_gust: Double
    let pop: Double
    let uvi: Double
    struct temp: Codable {
      let min: Double
      let max: Double
      let day: Double
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

