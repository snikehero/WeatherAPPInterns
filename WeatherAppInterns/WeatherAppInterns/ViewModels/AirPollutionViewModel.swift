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
}

