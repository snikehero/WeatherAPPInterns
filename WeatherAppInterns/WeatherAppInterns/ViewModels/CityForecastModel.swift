//
//  CtyForecastModel.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 22/05/23.
//

import Foundation
import CoreLocation
import SwiftUI
class CityForecastModel: ObservableObject {
  var coordinates: (lat: Double, lon: Double) = (0,0)
  @Published var forecasts: [ForecastViewModel] = [ForecastViewModel.mock,ForecastViewModel.mock1,ForecastViewModel.mock2,ForecastViewModel.mock3,ForecastViewModel.mock4,ForecastViewModel.mock5,ForecastViewModel.mock6,ForecastViewModel.mock7]
  @Published var city: CityViewModel = CityViewModel.mock
  @AppStorage ("location") var location: String = ""
  //5.'=
  var system: Int = 0 {
    didSet {
      for i in 0..<forecasts.count {
        forecasts[i].system = system
      }
    }
  }
  
  var id: UUID {
    return UUID()
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
            self.forecasts = forecast.list.map{ ForecastViewModel(forecast: $0, system: self.system)}
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
      apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(self.coordinates.lat)&lon=\(self.coordinates.lon)&appid=23892ea6d93b8685d75fae33906a91ed&units=metric") { (result: Result<Forecast,ApiService.APIError>) in
        switch result {
        case .success(let forecast):
          DispatchQueue.main.async {
            print("ForecastListViewmodel")
            self.city = CityViewModel(city: forecast.city )
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
    }
    //}
    
  }
  func getCityByName(cityName: String) -> CityForecastModel {
    var temp = CityForecastModel()
    let apiService = ApiService.shared
    CLGeocoder().geocodeAddressString(location) { placemarks, error in
      if let error = error {
        print(error.localizedDescription)
      }
      let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=23892ea6d93b8685d75fae33906a91ed&units=metric"
      //      if let lat = placemarks?.first?.location?.coordinate.latitude,
      //         let lon = placemarks?.first?.location?.coordinate.longitude {
      print("Coordenadas antes: \(self.coordinates.lat), \(self.coordinates.lon)")
      apiService.getJSON(urlString: urlString) { (result: Result<Forecast,ApiService.APIError>) in
        switch result {
        case .success(let forecast):
          DispatchQueue.main.async {
           
            temp.forecasts = forecast.list.map{ForecastViewModel(forecast: $0, system: self.system)}
            temp.city = CityViewModel(city: forecast.city )

            //print("Success")
            //print(forecast)
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
    return temp
  }
  
  func getCityByNameCityView(cityName: String){
    let apiService = ApiService.shared
    CLGeocoder().geocodeAddressString(location) { placemarks, error in
      if let error = error {
        print(error.localizedDescription)
      }
      let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=23892ea6d93b8685d75fae33906a91ed&units=metric"
      //      if let lat = placemarks?.first?.location?.coordinate.latitude,
      //         let lon = placemarks?.first?.location?.coordinate.longitude {
      print("Coordenadas antes: \(self.coordinates.lat), \(self.coordinates.lon)")
      apiService.getJSON(urlString: urlString) { (result: Result<Forecast,ApiService.APIError>) in
        switch result {
        case .success(let forecast):
          DispatchQueue.main.async {
           
            self.forecasts = forecast.list.map{ ForecastViewModel(forecast: $0, system: self.system)}
            self.city = CityViewModel(city: forecast.city )

            //print("Success")
            //print(forecast)
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
