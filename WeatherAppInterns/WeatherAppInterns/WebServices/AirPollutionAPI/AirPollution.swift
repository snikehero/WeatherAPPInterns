//
//  AirPollution.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 24/05/23.
//

import Foundation

struct AirPollution: Codable {
  struct List: Codable {
    struct Main: Codable {
      let aqi: Int
    }
    let main: Main
    struct Components: Codable {
      let co: Double
      let no: Double
      let no2: Double
      let o3: Double
      let so2: Double
      let pm2_5: Double
      let pm10: Double
      let nh3: Double
    }
    let components: Components
    
  }
  let list: [List]
}
