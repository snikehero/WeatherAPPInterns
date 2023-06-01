//
//  AirPollutionViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 24/05/23.
//

import Foundation

struct AirPollutionViewModel {
  let airPollution: AirPollution.List
  
  
  var index: String {
    return "\(airPollution.main.aqi)"
  }
  var co: String {
    return "\(airPollution.components.co)"
  }
  var no: String {
    return "\(airPollution.components.no)"
  }
  var no2: String {
    return "\(airPollution.components.no2)"
  }
  var o3: String {
    return "\(airPollution.components.o3)"
  }
  var so2: String {
    return "\(airPollution.components.so2)"
  }
  var pm25: String {
    return "\(airPollution.components.pm2_5)"
  }
  var pm10: String {
    return "\(airPollution.components.pm10)"
  }
  var nh3: String {
    return "\(airPollution.components.nh3)"
  }
  
 var airPollutionDescription: String {
   switch airPollution.main.aqi {
   case 1:
     return "Good"
   case 2:
     return "Fair"
   case 3:
     return "Moderate"
   case 4:
     return "Poor"
   case 5:
     return "Very Poor"
   default:
     return "Normal"
   }
   
  
   
 }
  var airPollutionHealth: String {
    switch airPollution.main.aqi {
    case 1:
      return "Air quality is good and poses no health risk"
    case 2:
      return "Air quality is satisfactory and poses little or no health risk"
    case 3:
      return "Air quality is moderate and poses little health risk"
    case 4:
      return "Air Quality is poor and poses medium health risk"
    case 5:
      return "Air Quality is very poor and poses high health risk"
    default:
      return "Air Quality is default"
   
  }
 
  
}
  var aqiIcon: String {
    switch airPollution.main.aqi {
    case 1:
      return "aqi.low"
    case 2:
      return "aqi.low"
    case 3:
      return "aqi.medium"
    case 4:
      return "aqi.medium"
    case 5:
      return "aqi.high"
    default:
      return "aqi.low"
    }
  }
}
extension AirPollutionViewModel {
  static var mock: Self {
    .init(airPollution: AirPollution.List(main: AirPollution.List.Main(aqi: 0), components: AirPollution.List.Components(co: 0, no: 0, no2: 0, o3: 0, so2: 0, pm2_5: 0, pm10: 0, nh3: 0)))
  }
  static var mock1: Self {
    .init(airPollution: AirPollution.List(main: AirPollution.List.Main(aqi: 4), components: AirPollution.List.Components(co: 0, no: 0, no2: 0, o3: 0, so2: 0, pm2_5: 0, pm10: 0, nh3: 0)))
  }
}

