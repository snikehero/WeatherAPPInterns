//
//  CityViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 22/05/23.
//

import Foundation

struct CityViewModel {
  let city: Forecast.City
  var cityName: String {
     return ("City: \(city.name)")
   }
   var sunrise: String {
     return ("Sunrise: \(city.sunrise)")
   }
   var sunset: String {
     return ("Sunset: \(city.sunset)")
   }
}
