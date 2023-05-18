//
//  WeatherService.swift
//  WeatherAppInterns
//
//  Created by Ulises Burns on 17/05/23.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject {
  
  private let locationManager = CLLocationManager()
  private let APIKEY = "23892ea6d93b8685d75fae33906a91ed"
  private var completionHandler: ((Weather) -> Void)?
  //private var completionHandler2: ((List) -> Void)?
  
  public override init() {
    super.init()
    locationManager.delegate = self
  }
  
  
  public func loadWeatherData( completionHandler: @escaping((Weather) -> Void)){
    self.completionHandler = completionHandler
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    
  }
//  public func loadWeatherData2(completionHandler2: @escaping((List) ->Void))
//  {
//    self.completionHandler2 = completionHandler2
//    locationManager.requestWhenInUseAuthorization()
//    locationManager.startUpdatingLocation()
//  }
  
  //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
  private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
    guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(APIKEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) {data, response, error in
      guard error == nil,let data = data else { return }
      
      if let response = try? JSONDecoder().decode(APIResponse.self, from: data){
        let weather = Weather(response: response)
        self.completionHandler?(weather)
      }
    }.resume()
    print(coordinates.latitude)
    print(coordinates.longitude)
  }
  
//  private func makeAnotherDataRequest (forCoordinates coordinates: CLLocationCoordinate2D)
//  {
//    let apicall = "https://api.openweathermap.org/data/2.5/forecast?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(APIKEY)&units=metric"
//    let url = URL(string: apicall)!
//    let request = URLRequest(url: url)
//    URLSession.shared.dataTask(with: request) { data, response, error in
//      guard let data = data else {
//        print(String(describing: error))
//        return
//      }
//      let anotherAnotherDecoder = JSONDecoder()
//      print("Entrando al decoder")
//      if let weatherList = try? anotherAnotherDecoder.decode(WeatherList.self, from: data)
//      {
//        print(weatherList.city.name)
//        weatherList.list.forEach{
//          print("Temperaturas: \($0.main.temp)")
//          //print("Weather Id: \($0.weather[].id)")
//          print("Wind Speed: \($0.wind.speed)")
//          
//        }
//        let cityName = List(response: weatherList)
//        self.completionHandler2?(cityName)
//        
//      }
//      else
//      {
//        print("Algo salio mal")
//      }
//
//
//
//    }.resume()
//  }
}


 extension WeatherService: CLLocationManagerDelegate {
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
  ) {
    guard let location = locations.first else { return }
    makeDataRequest(forCoordinates: location.coordinate)
    //makeAnotherDataRequest(forCoordinates: location.coordinate)
  }
  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error: \(error.localizedDescription)")
  }
}

struct WeatherList: Decodable {
  let list: [APIResponse]
  // let city: MyCity
  enum CodingKeys: String, CodingKey {
    case list = "list"
    //case city = "city"
  }
}

//struct MyCity: Decodable {
//  let id: Double
//  let name: String
//  enum CodingKeys: String, CodingKey {
//    case id = "id"
//    case name = "name"
//  }
//}
struct APIResponse: Decodable {
  let name: String
  let main: APIMain
  let weather: [APIWeather]
  let wind: APIWind
  enum CodingKeys: String, CodingKey {
    case name 
    case main = "main"
    case weather = "weather"
    case wind = "wind"
  }
//  let wind: APIWind
}


struct APIMain: Decodable {
  let temp: Double
  let tempMin: Double
  let tempMax: Double
  let pressure: Double
  let humidity: Double
  enum CodingKeys: String, CodingKey {
    case temp = "temp"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure = "pressure"
    case humidity = "humidity"
  }
}

struct APIWeather: Decodable {
  let description: String
  let iconName: String
  
  enum CodingKeys: String, CodingKey {
    case description
    case iconName = "main"
  }
}
struct APIWind: Decodable {
  let speed: Double
  enum CodingKeys: String, CodingKey {
    case speed = "speed"
  }
}
//struct APIWind: Decodable {
//  let speed: Double
//  let deg: Double
//  let gust: Double
//  enum CodingKeys: String, CodingKey {
//    case speed = "speed"
//    case deg = "deg"
//    case gust = "gust"
//  }
//}
