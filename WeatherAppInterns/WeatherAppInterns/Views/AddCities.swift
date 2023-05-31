//
//  AddCities.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 30/05/23.
//

import SwiftUI
import CoreLocation
import Combine

struct AddCities: View {
  @StateObject var forecastListVM = ForecastListViewModel()
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @State private var searchText = ""
  @State var tokens: Set<AnyCancellable> = []
  var body: some View {
    VStack {
      NavigationStack {
        Text("Searching for \(searchText)")
          .navigationTitle("Searchable Example")
        NavigationLink {
            EmptyView()
        } label: {
          CityView(forecasts: $forecastListVM.forecasts, city: $forecastListVM.city)
        }
      }
      .searchable(text: $searchText)
      .onAppear()
      {
        observeCoordinatesUpdates()
        observeLocationAccessDenied()
      }
      Button {
        forecastListVM.getCityByName(cityName: searchText)
      } label: {
        Text("hola")
      }

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
        forecastListVM.getWeatherForecast()
        forecastListVM.getCity()
        forecastListVM.location = "location"
      }
      .store(in: &tokens)
  }
  func observeLocationAccessDenied() {
    deviceLocationService.deniedLocationAccessPublisher
      .receive(on: DispatchQueue.main)
      .sink {
        print("Show some kind of alert to the user")
        forecastListVM.getWeatherForecast()
        forecastListVM.getCity()
        forecastListVM.location = "location"
      }
      .store(in: &tokens)
  }
  
}

struct AddCities_Previews: PreviewProvider {
  static var previews: some View {
    AddCities()
  }
}
