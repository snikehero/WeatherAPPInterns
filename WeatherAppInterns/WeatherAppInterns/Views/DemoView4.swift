//
//  DemoView4.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 05/06/23.
//

import SwiftUI
import CoreLocation
import Combine


struct DemoView4: View {
  @StateObject var forecastListVM = CityForecastModel()
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @StateObject private var dailyForecastListVM = DailyForecastListViewmodel()
  @State var tokens: Set<AnyCancellable> = []
  @State var coordinates: (lat: Double, lon: Double) = (0,0)
  @State var selectedSheet: showingSheets = .precipitation
  @State var isShowing = false
  @State var airPollutionListVM = AirPollutionListViewModel()
  var mockPreview = false
  var body: some View {
    NavigationStack {
      ZStack {
        BackgroundView()
        //Color("BackgroundColor")
          .ignoresSafeArea()
          .opacity(50)
        
        VStack {
          Spacer()
          ScrollView (showsIndicators: false){
            VStack (spacing: 10){
              ZStack {
                VStack {
                  ScrollView{
                    VStack {
                      //WeatherCityView()
                      //SummaryView(forecasts: $forecastListVM.forecasts,cityName: forecastListVM.city.cityName)
                      ButtonSubtitle(text: forecastListVM.forecasts.first?.overview ?? "overview")
                        .shadow(color: .black ,radius: 15, x: 2, y: 2)
                      //HourlyView(forecasts: $forecastListVM.forecasts)
                      Button{
                        print("AirQuality")
                        selectedSheet = .airQuality
                        isShowing.toggle()
                      } label: {
                        //AirPollutionView(airPollution: $airPollutionListVM.airPollutions)
                      }
                      
                      VStack(alignment: .leading, spacing: 10){
                        ButtonHeader(text: "8 - DAY FORECAST", systemImage: "calendar")
                        HeaderDivider()
                        //DaysView(dailyForecasts: $dailyForecastListVM.dailyForecasts)
                      }
                      .padding()
                      .background(.ultraThinMaterial)
                      .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                  }
                  .padding()
                }
              }
              HStack {
                Button{
                  print("UVIndex")
                  selectedSheet = .uvIndex
                  print(selectedSheet)
                  isShowing.toggle()
                } label: {
                  UVIndex()
                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Sunset")
                  
                } label: {
//                  Sunset(title: forecastListVM.city.sunset, description: "Sunrise: \(forecastListVM.city.sunrise)")
//                    .modifier(ExtraInfoButton())
                }
              }
              HStack {
                Button{
                  print("Wind")
                  selectedSheet = .wind
                  isShowing.toggle()
                } label: {
//                  Wind(forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
//                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Precipitation")
                  selectedSheet = .precipitation
                  isShowing.toggle()
                } label: {
//                  Precipitation(forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
//                    .modifier(ExtraInfoButton())
                }
              }
              HStack {
                Button{
                  print("FeelsLike")
                  selectedSheet = .feelsLike
                  isShowing.toggle()
                } label: {
//                  FeelsLike(forecasts: $forecastListVM.forecasts)
//                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Humidity")
                  selectedSheet = .humidity
                  isShowing.toggle()
                } label: {
//                  Humidity(forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
//                    .modifier(ExtraInfoButton())
                }
              }
              HStack {
                Button{
                  print("Visibility")
                  selectedSheet = .visibility
                  isShowing.toggle()
                } label: {
//                  Visibility(forecasts: $forecastListVM.forecasts)
//                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Pressure")
                  selectedSheet = .pressure
                  isShowing.toggle()
                } label: {
//                  Pressure(forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
//                    .modifier(ExtraInfoButton())
                }
              }
            }
            .sheet(isPresented: $isShowing){
              //SheetView(isShowing: $isShowing, selectedSheet: $selectedSheet, forecastListVM: forecastListVM, dailyForecastListVM: dailyForecastListVM, airPollutionListVM: airPollutionListVM)
            }
            
          }
          .onAppear(){
            observeCoordinatesUpdates()
            observeLocationAccessDenied()
            deviceLocationService.requestLocationUpdates()
          }
          Spacer()
        }
      }
//      .toolbar{
//        ToolbarItemGroup(placement: .bottomBar){
//          NavBarView()
//        }
     // }
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
struct DemoView4_Previews: PreviewProvider {
  static var previews: some View {
    DemoView4()
      .background(Color("BackgroundColor"))
  }
}




