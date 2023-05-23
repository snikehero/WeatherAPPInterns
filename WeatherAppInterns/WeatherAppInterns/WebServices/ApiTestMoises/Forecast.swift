//
//  Forecast.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 17/05/23.
//

import Foundation
struct MyWeatherList: Decodable {
  let list: [MyWeatherMain] //Definicion de variables
  let city: MyCity
  enum CodingKeys: String, CodingKey {
    case list = "list"
    case city = "city"
  }
}

struct MyWeatherMain: Decodable {
  let dt: Date
  let visibility: Double
  let pop: Double
  let main: MyWeather
  let weather: [MyNewWeather]
  let clouds: MyClouds
  let wind: MyWind
//  let visibility: MyVisibility
  enum CodingKeys: String, CodingKey {
    case dt = "dt"
    case main = "main"
    case weather = "weather"
    case clouds = "clouds"
    case wind = "wind"
    case visibility = "visibility"
    case pop = "pop"
//  case visibility = "visibility"
  }
}

struct MyWeather: Decodable {
  let temp: Double //Definicion de las variables del ultimo nivel
  let tempMin: Double
  let tempMax: Double
  let pressure: Double
  let fellsLike: Double
  let humidity: Int
  enum CodingKeys: String, CodingKey { //Llamar los casos de las variables igual al json
    case temp = "temp"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure = "pressure"
    case fellsLike = "feels_like"
    case humidity = "humidity"
  }
}
struct MyNewWeather: Decodable {
  let id: Double
  let main: String
  let description: String
  let icon: String
  var weatherIconURL: URL {
    let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
    return URL(string: urlString)!
  }
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case main = "main"
    case description = "description"
    case icon = "icon"
  }
}
struct MyClouds: Decodable {
  let all: Int
  enum CodingKeys: String, CodingKey {
    case all = "all"
  }
}

struct MyWind: Decodable {
  let speed: Double
  enum CodingKeys: String, CodingKey {
    case speed = "speed"
  }
}
//struct MyVisibility: Decodable {
//  let visibility: Double
//  enum CodingKeys: String, CodingKey {
//    case visibility = "visibility"
//  }
//}
struct MyCity: Decodable {
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




struct Forecast: Decodable {
  struct List: Codable {
    let dt: Date
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
      let description: String
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
