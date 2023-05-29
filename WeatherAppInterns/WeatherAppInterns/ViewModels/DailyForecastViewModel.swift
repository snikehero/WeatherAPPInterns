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
  var id: UUID {
    return UUID()
  }
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
  var uvi: String {
    return "\(Self.numberFormatter.string(for: dailyForecast.uvi) ?? "0")"
    //return "\(dailyForecast.uvi)"
  }
  var subtitle: String {
    switch dailyForecast.uvi.rounded() {
    case 0...2:
      return "Low"
    case 3...5:
      return "Moderate"
    case 6...7:
      return "High"
    case 8...10:
      return "Very High"
    case 11...20:
      return "Extreme"
    default:
      return "Normal"
    }
  }
  var description: String {
    switch dailyForecast.uvi.rounded() {
    case 0...2:
      return "Wear sunglasses on bright days."
    case 3...5:
      return "Stay in shade near midday"
    case 6...7:
      return "Reduce time in the sun."
    case 8...10:
      return "Minimize sun exposure"
    case 11...20:
      return "Try to avoid sun exposure"
    default:
      return "Normal"
    }
  }
  
}
