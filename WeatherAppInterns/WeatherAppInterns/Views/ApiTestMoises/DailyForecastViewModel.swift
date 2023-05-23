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
    dateFormatter.dateFormat = "EEEE, d, HH:mm"
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
  
  var day: String {
    return Self.dateFormatter.string(from: dailyForecast.dt)
  }
  var maxTemp: String {
    return "\(Self.numberFormatterDecimal.string(for: dailyForecast.temp.max) ?? "0")"
  }
  var minTemp: String {
    return "\(Self.numberFormatterDecimal.string(for: dailyForecast.temp.min) ?? "0")"
  }
  
  
}
