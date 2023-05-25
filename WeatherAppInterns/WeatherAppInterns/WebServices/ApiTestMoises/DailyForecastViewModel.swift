//
//  DailyForecastViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 23/05/23.
//

import Foundation


struct DailyForecastViewModel {
  let dailyForecast: DailyForecast.Daily
  
  private static var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter
  }
  
  private static var numberFormatter: NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.maximumFractionDigits = 0
    return numberFormatter
  }
  
  private static var numberFormatterDecimal: NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .percent
    return numberFormatter
  }
//  func convert(_ temp: Double) -> Double {
//    let celsius = temp - 273.5
//    if system == 0 {
//      return celsius
//    } else {
//      return celsius * 9 / 5 + 32
//    }
//  }
  var day: String {
    //return Self.dateFormatter.string(from: NSDate(timeIntervalSince1970:(dailyForecast.dt) as Date)
    return "\(Self.dateFormatter.string(from: NSDate(timeIntervalSince1970: dailyForecast.dt) as Date))"
    // b(dataFormatter2.string(from: NSDate(timeIntervalSince1970: (forecast?.city.sunset)!) as Date))
  }
  var maxTemp: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.temp.max) ?? "0")°"
  }
  var minTemp: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.temp.min) ?? "0")°"
  }
  
  
}
