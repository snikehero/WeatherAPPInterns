//
//  AirPollutionListViewModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 24/05/23.
//

import Foundation
import CoreLocation
import SwiftUI
class AirPollutionListViewModel: ObservableObject {
  var coordinates: (lat: Double, lon: Double) = (0,0)
  @Published var airPollutions: [AirPollutionViewModel] = [AirPollutionViewModel.mock]
  @AppStorage ("location") var location: String = ""
  init() {
    if location != "" {
      //getWeatherForecast()
      //getCity()
      
    }
  }
  
  var units: String = "metric"
  func getAirPollution(){
    let apiString  = "http://api.openweathermap.org/data/2.5/air_pollution?lat=50&lon=50&appid=23892ea6d93b8685d75fae33906a91ed"
    let apiService = ApiService.shared

    CLGeocoder().geocodeAddressString(location) { placemarks, error in
      if let error = error {
        print(error.localizedDescription)
      }
//      if let lat = placemarks?.first?.location?.coordinate.latitude,
//         let lon = placemarks?.first?.location?.coordinate.longitude {
        print("Coordenadas antes: \(self.coordinates.lat), \(self.coordinates.lon)")
      apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(self.coordinates.lat)&lon=\(self.coordinates.lon)&appid=23892ea6d93b8685d75fae33906a91ed") { (result: Result<AirPollution,ApiService.APIError>) in
          switch result {
          case .success(let airPollution):
            //print(forecast)
            DispatchQueue.main.async {
              self.airPollutions = airPollution.list.map{ AirPollutionViewModel(airPollution: $0)}
              print("DispatchQueue AirPollution")
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
}
