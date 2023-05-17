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
  
  public override init() {
    super.init()
    locationManager.delegate = self
  }
  
  
  public func loadWeatherData( completionHandler: @escaping((Weather) -> Void)){
    self.completionHandler = completionHandler
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    
  }
  
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
  }
}


 extension WeatherService: CLLocationManagerDelegate {
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
  ) {
    guard let location = locations.first else { return }
    makeDataRequest(forCoordinates: location.coordinate)
    
  }
  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error: \(error.localizedDescription)")
  }
}


struct APIResponse: Decodable {
  let name: String
  let main: APIMain
  let weather: [APIWeather]
}

struct APIMain: Decodable {
  let temp: Double
}

struct APIWeather: Decodable {
  let description: String
  let iconName: String
  
  enum CodingKeys: String, CodingKey {
    case description
    case iconName = "main"
  }
}
