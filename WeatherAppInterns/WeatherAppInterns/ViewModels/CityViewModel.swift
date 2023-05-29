//
//  CityViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 22/05/23.
//

import Foundation

struct CityViewModel {
  let city: Forecast.City
  private static var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter
  }
  var cityName: String {
     return ("\(city.name)")
   }
   var sunrise: String {
     return ("\(Self.dateFormatter.string(from: NSDate(timeIntervalSince1970: city.sunrise) as Date))")
   }
   var sunset: String {
     return ("\(Self.dateFormatter.string(from: NSDate(timeIntervalSince1970: city.sunset) as Date))")
     //return ("\(Self.dateFormatter.string(for: city.sunset) ?? "0")")
   }
}
