//
//  ForecastListViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 22/05/23.
//

import Foundation
import CoreLocation
import SwiftUI
class ForecastListViewModel: ObservableObject {
  var coordinates: (lat: Double, lon: Double) = (0,0)
  @Published var forecasts: [ForecastViewModel] = []
  @Published var city: CityViewModel = .init(city: .init(id: 0, name: "", sunrise: 0, sunset: 0))
  @AppStorage ("location") var location: String = ""
  init() {
    if location != "" {
      //getWeatherForecast()
      //getCity()
      
    }
  }
  
  var units: String = "metric"
  func getWeatherForecast(){

    let apiService = ApiService.shared

    CLGeocoder().geocodeAddressString(location) { placemarks, error in
      if let error = error {
        print(error.localizedDescription)
      }
//      if let lat = placemarks?.first?.location?.coordinate.latitude,
//         let lon = placemarks?.first?.location?.coordinate.longitude {
        print("Coordenadas antes: \(self.coordinates.lat), \(self.coordinates.lon)")
      apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(self.coordinates.lat)&lon=\(self.coordinates.lon)&appid=23892ea6d93b8685d75fae33906a91ed&units=\(self.units)") { (result: Result<Forecast,ApiService.APIError>) in
          switch result {
          case .success(let forecast):
            //print(forecast)
            DispatchQueue.main.async {
              self.forecasts = forecast.list.map{ ForecastViewModel(forecast: $0)}
              print("DispatchQueue getWeatherForecast")
              print(self.coordinates.lat)
              print(self.coordinates.lon)
            }
            case .failure(let apiError):
            switch apiError {
            case .error(let errorString):
              print(errorString)
            }
          }
        }
      //}
    }
  }
  func getCity() {
    let apiService = ApiService.shared

    CLGeocoder().geocodeAddressString(location) { placemarks, error in
      if let error = error {
        print(error.localizedDescription)
      }
      //print("Hola Desde Ciudad1")
//      if let lat = placemarks?.first?.location?.coordinate.latitude,
//         let lon = placemarks?.first?.location?.coordinate.longitude {
        apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(self.coordinates.lat)&lon=\(self.coordinates.lon)&appid=23892ea6d93b8685d75fae33906a91ed&units=standard") { (result: Result<Forecast,ApiService.APIError>) in
          switch result {
          case .success(let forecast):
            DispatchQueue.main.async {
              self.city = CityViewModel(city: forecast.city )
            }
            case .failure(let apiError):
            switch apiError {
            case .error(let errorString):
              print(errorString)
            }
          }
        }
      }
    //}
    
  }
 
  
}
