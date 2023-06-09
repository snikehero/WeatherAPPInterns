//
//  DemoView4.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 05/06/23.
//

import SwiftUI
import CoreLocation
import Combine


struct WeatherView: View {
  @EnvironmentObject var forecastListVM: CityForecastModel
  @EnvironmentObject var dailyForecastListVM: DailyForecastListViewmodel
  @EnvironmentObject var airPollutionListVM: AirPollutionListViewModel
  @EnvironmentObject var deviceLocationService: DeviceLocationService
  @State var selectedSheet: showingSheets = .precipitation
  @State var isShowing = false
  var mockPreview = false
  var body: some View {
    NavigationStack {
      ZStack {
        //BackgroundView()
        Color("BackgroundColor")
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
                      SummaryView()
                        .environmentObject(forecastListVM)
                      ButtonSubtitle(text: forecastListVM.forecasts.first?.overview ?? "overview")
                        .shadow(color: .black ,radius: 15, x: 2, y: 2)
                      HourlyView()
                        .environmentObject(forecastListVM)
                      Button{
                        print("AirQuality")
                        selectedSheet = .airQuality
                        isShowing.toggle()
                      } label: {
                        AirPollutionView()
                          .environmentObject(airPollutionListVM)
                      }
                      
                      VStack(alignment: .leading, spacing: 10){
                        ButtonHeader(text: "8 - DAY FORECAST", systemImage: "calendar")
                        HeaderDivider()
                        DaysView()
                          .environmentObject(dailyForecastListVM)
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
                    .environmentObject(dailyForecastListVM)
                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Sunset")
                  
                } label: {
                  Sunset()
                    .environmentObject(forecastListVM)
                    .modifier(ExtraInfoButton())
                }
              }
              HStack {
                Button{
                  print("Wind")
                  selectedSheet = .wind
                  isShowing.toggle()
                } label: {
                  Wind()
                    .environmentObject(forecastListVM)
                    .environmentObject(dailyForecastListVM)
                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Precipitation")
                  selectedSheet = .precipitation
                  isShowing.toggle()
                } label: {
                  Precipitation()
                    .environmentObject(forecastListVM)
                    .environmentObject(dailyForecastListVM)
                    .modifier(ExtraInfoButton())
                }
              }
              HStack {
                Button{
                  print("FeelsLike")
                  selectedSheet = .feelsLike
                  isShowing.toggle()
                } label: {
                  FeelsLike()
                    .environmentObject(forecastListVM)
                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Humidity")
                  selectedSheet = .humidity
                  isShowing.toggle()
                } label: {
                  Humidity()
                    .environmentObject(forecastListVM)
                    .environmentObject(dailyForecastListVM)
                    .modifier(ExtraInfoButton())
                }
              }
              HStack {
                Button{
                  print("Visibility")
                  selectedSheet = .visibility
                  isShowing.toggle()
                } label: {
                  Visibility()
                    .environmentObject(forecastListVM)
                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Pressure")
                  selectedSheet = .pressure
                  isShowing.toggle()
                } label: {
                  Pressure()
                    .environmentObject(forecastListVM)
                    .environmentObject(dailyForecastListVM)
                    .modifier(ExtraInfoButton())
                }
              }
            }
            .sheet(isPresented: $isShowing){
              SheetView(isShowing: $isShowing, selectedSheet: $selectedSheet)
                .environmentObject(forecastListVM)
                .environmentObject(dailyForecastListVM)
                .environmentObject(airPollutionListVM)
            }
            
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
  
}
struct WeatherView_Previews: PreviewProvider {
  static var previews: some View {
    WeatherView()
      .background(Color("BackgroundColor"))
  }
}




