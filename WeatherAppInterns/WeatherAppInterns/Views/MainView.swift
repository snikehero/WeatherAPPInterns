//
//  MainView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 05/06/23.
//

import SwiftUI
import CoreLocation
import Combine

struct MainView: View {
    @StateObject var forecastListVM = CityForecastModel()
    @StateObject var deviceLocationService = DeviceLocationService.shared
    @StateObject var dailyForecastListVM = DailyForecastListViewmodel()
    @StateObject var airPollutionListVM = AirPollutionListViewModel()
    @StateObject var cityListVM = CityListViewModel()
    @State var tokens: Set<AnyCancellable> = []
    @State var coordinates: (lat: Double, lon: Double) = (0,0)
    @State var selectedSheet: showingSheets = .precipitation
    @EnvironmentObject var networkMonitor: NetworkMonitor //:)
    var mockPreview = false
    var body: some View {
      
        TabView {
            testMainPage()
                .environmentObject(cityListVM)
                      .tabItem {
                        Label("", systemImage: "list.bullet")
                          .font(.body.bold())
                           .symbolVariant(.fill)
                      }
          DisplayCityView() //Llamada a la vista
            .environmentObject(cityListVM)
            .tabItem{
              Label("",systemImage: "building.2.fill")
            }
            .environmentObject(cityListVM)
            WeatherView()
                .environmentObject(forecastListVM)
                .environmentObject(dailyForecastListVM)
                .environmentObject(airPollutionListVM)
                .environmentObject(deviceLocationService)
                .tabItem{
                    Label("", systemImage: "location")
                        .font(.body.bold())
                        .symbolVariant(.fill)
                }
          
            
        }
        .onAppear {
            observeCoordinatesUpdates()
            observeLocationAccessDenied()
            deviceLocationService.requestLocationUpdates()
            cityListVM.addCity(cityToAdd: forecastListVM)
            print(cityListVM.cities.count)
        }
    }
    func observeCoordinatesUpdates()
    {
        print("Entro a observeCoodrinates")
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink {completion in
                if case .failure (let error) = completion {
                    print(error)
                    print("Error de ObserveCOordinates")
                }
            } receiveValue: { coordinates in
                print("Entro")
                self.coordinates = (coordinates.latitude, coordinates.longitude)
                forecastListVM.coordinates = (coordinates.latitude, coordinates.longitude)
                dailyForecastListVM.coordinates = (coordinates.latitude,coordinates.longitude)
                airPollutionListVM.coordinates = (coordinates.latitude,coordinates.longitude)
                forecastListVM.getWeatherForecast()
                forecastListVM.getCity()
                dailyForecastListVM.getDailyWeatherForecast()
                forecastListVM.location = "location"
                dailyForecastListVM.location = "location"
                airPollutionListVM.getAirPollution()
            }
            .store(in: &tokens)
    }
    func observeLocationAccessDenied() {
        print("Entro a Observelocation")
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Show some kind of alert to the user")
                if mockPreview == false {
                    self.coordinates = (37.3230,-122.0322)
                    forecastListVM.coordinates = (37.3230,-122.0322)
                    dailyForecastListVM.coordinates = (37.3230,-122.0322)
                    airPollutionListVM.coordinates = (37.3230, -122.0322)
                    forecastListVM.getWeatherForecast()
                    forecastListVM.getCity()
                    dailyForecastListVM.getDailyWeatherForecast()
                    forecastListVM.location = "location"
                    dailyForecastListVM.location = "location"
                    airPollutionListVM.getAirPollution()
                }
                
            }
            .store(in: &tokens)
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
