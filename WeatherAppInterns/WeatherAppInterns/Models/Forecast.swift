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
    var name: String
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

extension Forecast {
  static var mock: Self {
    .init(list: [List.init(dt: 0, main: List.Main(temp: 0, feels_like: 0, temp_min: 0, temp_max: 0, pressure: 0, sea_level: 0, grnd_level: 0, humidity: 0), weather: [List.Weather(id: 0, main: "0", description: "0", icon: "0")], clouds: List.Clouds(all: 0), wind: List.Wind(speed: 0, deg: 0, gust: 0), pop: 0, visibility: 0)], city: City.init(id: 0, name: "Mexico", sunrise: 0, sunset: 0))
  }
}
