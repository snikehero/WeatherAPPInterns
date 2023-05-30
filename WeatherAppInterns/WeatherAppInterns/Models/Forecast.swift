//
//  Forecast.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 17/05/23.
//

import Foundation

// CREATE MOCK




struct Forecast: Decodable {
  struct List: Codable {
    let dt: Double
    struct Main: Codable {
      let temp: Double
      let feels_like: Double
      let temp_min: Double
      let temp_max: Double
      let pressure: Int
      let sea_level: Int
      let grnd_level: Int
     let humidity: Int
    }
    let main: Main
    struct Weather: Codable {
      let id: Int
      let main: String
      let description: String
      let icon: String
    }
    let weather: [Weather]
    struct Clouds: Codable {
      let all: Int
    }
    let clouds: Clouds
    struct Wind: Codable {
      let speed: Double
      let deg: Int
      let gust: Double
    }
    let wind: Wind
    let pop: Double
    let visibility: Int
    
  }
  let list: [List]
  struct City: Decodable {
    let id: Double
    let name: String
    let sunrise: Double
    let sunset: Double
    enum CodingKeys: String, CodingKey {
      case id = "id"
      case name = "name"
      case sunrise = "sunrise"
      case sunset = "sunset"
    }
  }
  let city: City
  enum CodingKeys: String, CodingKey {
    case list = "list"
    case city = "city"
  }
}
