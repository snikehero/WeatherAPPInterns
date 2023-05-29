//
//  LocationManager.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 16/05/23.
//

import Foundation
import Combine
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  let manager = CLLocationManager()
  
  @Published var location: CLLocationCoordinate2D?
  @Published var isLoading = false
  
  var coordinatesPublisher = PassthroughSubject<CLLocationCoordinate2D,Error>()
  
  override init() {
    super.init()
  }
  static let shared = LocationManager()
  
  
  func requestLocation() {
    isLoading = true
    manager.requestLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    location = locations.first?.coordinate
    isLoading = false
  }
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error getting location", error)
    isLoading = false
  }
  
}
