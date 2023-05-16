//
//  MoisesView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 16/05/23.
//
import Combine
import SwiftUI

struct MoisesView: View {
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @State var tokens: Set<AnyCancellable> = []
  @State var coordinates: (lat: Double, lon: Double) = (0,0)
  var body: some View {
    VStack
    {
      Text("Lattitude: \(coordinates.lat)")
        .font(.largeTitle)
      Text("Longitude: \(coordinates.lon)")
        .font(.largeTitle)
    }
    .onAppear()
    {
      observeCoordinatesUpdates()
      observeLocationAccessDenied()
      deviceLocationService.requestLocationUpdates()
    }
  }
 func observeCoordinatesUpdates()
  {
    deviceLocationService.coordinatesPublisher
      .receive(on: DispatchQueue.main)
      .sink {completion in
        if case .failure (let error) = completion {
          print(error)
        }
      } receiveValue: { coordinates in
        self.coordinates = (coordinates.latitude, coordinates.longitude)
      }
      .store(in: &tokens)
  }
  
  func observeLocationAccessDenied() {
    deviceLocationService.deniedLocationAccessPublisher
      .receive(on: DispatchQueue.main)
      .sink {
        print("Show some kind of alert to the user")
      }
      .store(in: &tokens)
  }
}

struct MoisesView_Previews: PreviewProvider {
  static var previews: some View {
    MoisesView()
  }
}
