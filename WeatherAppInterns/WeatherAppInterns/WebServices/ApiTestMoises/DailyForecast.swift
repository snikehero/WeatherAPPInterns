
//  DailyForecast.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 23/05/23.
//

import Foundation
//Struct DailyForecast
struct DailyForecast: Decodable {
  struct Daily: Codable {
    let dt: Date
    struct temp: Codable {
      let min: Double
      let max: Double
    }
    let temp: temp
  }
  let daily: [Daily]
}

