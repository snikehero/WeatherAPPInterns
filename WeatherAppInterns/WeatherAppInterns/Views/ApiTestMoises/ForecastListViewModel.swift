//
//  ForecastListViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 22/05/23.
//

import Foundation
import CoreLocation
class ForecastListViewModel: ObservableObject {
  var coordinates: (lat: Double, lon: Double) = (0,0)
  @Published var forecasts: [ForecastViewModel] = []
  @Published var city: String = ""
  private let APIKEY = "23892ea6d93b8685d75fae33906a91ed"
  var location: String = ""
  
  func getWeatherForecast(){

    let apiService = ApiService.shared

    CLGeocoder().geocodeAddressString(location) { placemarks, error in
      if let error = error {
        print(error.localizedDescription)
      }
//      if let lat = placemarks?.first?.location?.coordinate.latitude,
//         let lon = placemarks?.first?.location?.coordinate.longitude {
        print("Coordenadas antes: \(self.coordinates.lat), \(self.coordinates.lon)")
      apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(self.coordinates.lat)&lon=\(self.coordinates.lon)&appid=\(self.APIKEY)&units=metric") { (result: Result<Forecast,ApiService.APIError>) in
          switch result {
          case .success(let forecast):
            //print(forecast)
            print(self.coordinates.lat)
            print(self.coordinates.lon)
            DispatchQueue.main.async {
              self.forecasts = forecast.list.map{ ForecastViewModel(forecast: $0)}
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
      print("Hola Desde Ciudad1")
//      if let lat = placemarks?.first?.location?.coordinate.latitude,
//         let lon = placemarks?.first?.location?.coordinate.longitude {
        apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(self.coordinates.lat)&lon=\(self.coordinates.lon)&appid=23892ea6d93b8685d75fae33906a91ed&units=metric") { (result: Result<Forecast,ApiService.APIError>) in
          switch result {
          case .success(let city):
            DispatchQueue.main.async {
              self.city = city.city.name
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
