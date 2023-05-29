
//  DailyForecastListViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 23/05/23.
//

import Foundation
import CoreLocation
import SwiftUI
class DailyForecastListViewmodel: ObservableObject {
  var coordinates: (lat: Double, lon: Double) = (0,0)
  @Published var dailyForecasts: [DailyForecastViewModel] = []
  private let APIKEY = "be2939953972b861ba74daace3cb370d"
  @AppStorage ("location") var location: String = ""
  var units: String = "metric"
  init() {
    if location != "" {
      //getDailyWeatherForecast()
      
    }
  }

  func getDailyWeatherForecast(){

    let apiService = ApiService.shared

    CLGeocoder().geocodeAddressString(location) { placemarks, error in
      if let error = error {
        print(error.localizedDescription)
      }
//      if let lat = placemarks?.first?.location?.coordinate.latitude,
//         let lon = placemarks?.first?.location?.coordinate.longitude {
        print("Coordenadas antes: \(self.coordinates.lat), \(self.coordinates.lon)")
      apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(self.coordinates.lat)&lon=\(self.coordinates.lon)&exclude=hourly,minutely&appid=\(self.APIKEY)&units=\(self.units)") { (result: Result<DailyForecast,ApiService.APIError>) in
          switch result {
          case .success(let dailyForecast):
            //print(forecast)
            print(self.coordinates.lat)
            print(self.coordinates.lon)
            DispatchQueue.main.async {
              self.dailyForecasts = dailyForecast.daily.map{DailyForecastViewModel(dailyForecast: $0)}
            }
            case .failure(let apiError):
            switch apiError {
            case .error(let errorString):
              print("Error")
              print(errorString)
            }
          }
        }
      //}
    }
  }
  
  
}

