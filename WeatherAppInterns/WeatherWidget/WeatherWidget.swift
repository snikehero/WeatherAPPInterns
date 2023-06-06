//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Ulises Burns on 24/05/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(),forecastListVM: CityForecastModel(), deviceLocationService: DeviceLocationService.shared, configuration: ConfigurationIntent())
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    _ = SimpleEntry(date: Date(), forecastListVM: CityForecastModel(), deviceLocationService: DeviceLocationService.shared, configuration: configuration)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    
    var entries: [SimpleEntry] = []
    completion(Timeline(entries: entries, policy: .atEnd))
    
    
    let entry = SimpleEntry(date: Date(), forecastListVM: CityForecastModel(), deviceLocationService: DeviceLocationService.shared, configuration: configuration)
    entries.append(entry)
  }
}
  
  struct SimpleEntry: TimelineEntry {
    var date: Date
    
    @StateObject var forecastListVM = CityForecastModel()
    @StateObject var deviceLocationService = DeviceLocationService.shared
    @StateObject private var dailyForecastListVM = DailyForecastListViewmodel()
    @State var coordinates: (lat: Double, lon: Double) = (0,0)
    let configuration: ConfigurationIntent
  }
  
struct WeatherWidgetEntryView : View {
  @Environment(\.widgetFamily) var family
  var body: some View {
    
    if family == .systemSmall{
      SmallWeatherWidget(forecastListVM: CityForecastModel(), deviceLocationService: DeviceLocationService.shared, date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
    }
    if family == .systemMedium{
      MediumWeatherWidget(forecastListVM: CityForecastModel(), deviceLocationService: DeviceLocationService.shared, date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
    }
    if family == .systemLarge{
      LargeWeatherWidget(forecastListVM: CityForecastModel(), deviceLocationService: DeviceLocationService.shared, date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
    }
  }
}
    
    
    
    
    struct SmallWeatherWidget: View {
      
      @StateObject var forecastListVM = CityForecastModel()
      @StateObject var deviceLocationService = DeviceLocationService.shared
      @StateObject private var dailyForecastListVM = DailyForecastListViewmodel()
      @State var coordinates: (lat: Double, lon: Double) = (0,0)
      
      
      var date: String
      var temp: Double
      var emoji: String
      var city: String
      var description: String
      var tempMax: Double
      var tempMin: Double
      var body: some View {
        ZStack {
          ContainerRelativeShape()
            .fill(Color.blue.opacity(0.6))
            .shadow(color: .black ,radius: 15, x: 2, y: 2)
          
          VStack{
            VStack(alignment: .leading, spacing: 4) {
              CityWidget(text: forecastListVM.city.cityName)
              BigTempWigdet(text: forecastListVM.forecasts.first?.current ?? "")
              Text(forecastListVM.forecasts.first?.emoji ?? "")
              DescriptionWidget(text: forecastListVM.forecasts.first?.weatherDescription ?? "")
              MaxMinWidget(text: "Min:.\(forecastListVM.forecasts.first?.low ?? "0")° Max:.\(forecastListVM.forecasts.first?.high ?? "0")°")
            }
          } .padding()
        }
        .onAppear(){
          
          
        }
      }
      
      func observeCoordinatesUpdates() {
        deviceLocationService.coordinatesPublisher
          .receive(on: DispatchQueue.main)
          .sink {completion in
            if case .failure (let error) = completion {
              print(error)
            }
          } receiveValue: { coordinates in
            self.coordinates = (coordinates.latitude, coordinates.longitude)
            forecastListVM.coordinates = (coordinates.latitude, coordinates.longitude)
            dailyForecastListVM.coordinates = (coordinates.latitude,coordinates.longitude)
            forecastListVM.getWeatherForecast()
            forecastListVM.getCity()
            dailyForecastListVM.getDailyWeatherForecast()
            forecastListVM.location = "location"
            dailyForecastListVM.location = "location"
            
          }
        //      .store(in: &tokens)
      }
      func observeLocationAccessDenied() {
        deviceLocationService.deniedLocationAccessPublisher
          .receive(on: DispatchQueue.main)
          .sink {
            print("Show some kind of alert to the user")
            self.coordinates = (37.3230,-122.0322)
            forecastListVM.coordinates = (37.3230,-122.0322)
            dailyForecastListVM.coordinates = (37.3230,-122.0322)
            forecastListVM.getWeatherForecast()
            forecastListVM.getCity()
            dailyForecastListVM.getDailyWeatherForecast()
            forecastListVM.location = "location"
            dailyForecastListVM.location = "location"
            
          }
        
        //      .store(in: &tokens)
      }
    }
    
    
    struct MediumWeatherWidget: View {
      @StateObject var forecastListVM = CityForecastModel()
      @StateObject var deviceLocationService = DeviceLocationService.shared
      @StateObject private var dailyForecastListVM = DailyForecastListViewmodel()
      @State var coordinates: (lat: Double, lon: Double) = (0,0)
      var date: String
      var temp: Double
      var emoji: String
      var city: String
      var description: String
      var tempMax: Double
      var tempMin: Double
      var body: some View {
        
        VStack (spacing: 7){
          VStack(alignment: .leading, spacing: 4) {
            
            HStack(){
              
              CityWidget(text: forecastListVM.city.cityName)
              Spacer()
              Text(forecastListVM.forecasts.first?.emoji ?? "")
                .font(.body)
            }
            HStack{
              
              BigTempWigdet(text: forecastListVM.forecasts.first?.current ?? "")
              Spacer()
              
              VStack{
                DescriptionWidget(text: forecastListVM.forecasts.first?.weatherDescription ?? "")
                MaxMinWidget(text: "Min:.\(forecastListVM.forecasts.first?.low ?? "0")° Max:.\(forecastListVM.forecasts.first?.high ?? "0")°")
              }
            }
          }
          VStack{
            HStack(spacing: 28){
              ForEach(1..<7){ element in
                VStack(spacing: 3){
                  Text(forecastListVM.forecasts.first?.dayNumber ?? "0")
                    .foregroundColor(.white)
                  Text(forecastListVM.forecasts.first?.emoji ?? "")
                  Text("\(forecastListVM.forecasts.first?.current ?? "0")°")  //hourly temp 3hrs
                    .foregroundColor(.white)
                }
              }
            }
          }
        }
        .padding()
        .background(Color.blue.opacity(0.6))
        .shadow(color: .black ,radius: 15, x: 2, y: 2)
      }
    }
    
    
    
    
    
    struct LargeWeatherWidget: View {
      @StateObject var forecastListVM = CityForecastModel()
      @StateObject var deviceLocationService = DeviceLocationService.shared
      @StateObject private var dailyForecastListVM = DailyForecastListViewmodel()
      @State var coordinates: (lat: Double, lon: Double) = (0,0)
      var date: String
      var temp: Double
      var emoji: String
      var city: String
      var description: String
      var tempMax: Double
      var tempMin: Double
      var body: some View {
        VStack{
          VStack (spacing: 7){
            VStack(alignment: .leading, spacing: 4) {
              
              HStack(){
                
                CityWidget(text: forecastListVM.city.cityName)
                Spacer()
                Text(emoji)
                  .font(.body)
              }
              HStack{
                
                BigTempWigdet(text: forecastListVM.forecasts.first?.current ?? "")
                
                Spacer()
                VStack(alignment: .trailing) {
                  DescriptionWidget(text: forecastListVM.forecasts.first?.weatherDescription ?? "")
                  
                  MaxMinWidget(text: "Min:.\(forecastListVM.forecasts.first?.low ?? "0")° Max:.\(forecastListVM.forecasts.first?.high ?? "0")°")
                }
              }
            }
            Divider()
              .overlay(.white)
            
            VStack{
              HStack(spacing: 28){
                ForEach(1..<7){ element in
                  VStack(spacing: 3){
                    Text(forecastListVM.forecasts.first?.dayNumber ?? "0")
                      .foregroundColor(.white)
                    Text(forecastListVM.forecasts.first?.emoji ?? "")
                    Text("\(forecastListVM.forecasts.first?.current ?? "0")°")
                      .foregroundColor(.white)
                  }
                }
              }
            }
            Divider()
              .overlay(.white)
            
            VStack(spacing: 18) {
              ForEach(1..<6){ row in
                VStack(){
                  HStack(spacing: 20){
                    Text(forecastListVM.forecasts.first?.dayNumber ?? "0")
                      .foregroundColor(.white)
                    Text(forecastListVM.forecasts.first?.emoji ?? "")
                    Text(forecastListVM.forecasts.first?.low ?? "0")
                      .foregroundColor(.white)
                    Text("------------")
                      .foregroundColor(.white)
                    Text(forecastListVM.forecasts.first?.high ?? "0")
                      .foregroundColor(.white)
                  }
                }
              }
            }
          }
          .padding()
          .background(Color.blue.opacity(0.6))
          .shadow(color: .black ,radius: 15, x: 2, y: 2)
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
            forecastListVM.coordinates = (coordinates.latitude, coordinates.longitude)
            dailyForecastListVM.coordinates = (coordinates.latitude,coordinates.longitude)
            forecastListVM.getWeatherForecast()
            forecastListVM.getCity()
            dailyForecastListVM.getDailyWeatherForecast()
            forecastListVM.location = "location"
            dailyForecastListVM.location = "location"
            
          }
        //      .store(in: &tokens)
      }
      func observeLocationAccessDenied() {
        deviceLocationService.deniedLocationAccessPublisher
          .receive(on: DispatchQueue.main)
          .sink {
            print("Show some kind of alert to the user")
            self.coordinates = (37.3230,-122.0322)
            forecastListVM.coordinates = (37.3230,-122.0322)
            dailyForecastListVM.coordinates = (37.3230,-122.0322)
            forecastListVM.getWeatherForecast()
            forecastListVM.getCity()
            dailyForecastListVM.getDailyWeatherForecast()
            forecastListVM.location = "location"
            dailyForecastListVM.location = "location"
            
          }
        //      .store(in: &tokens)
      }
    }
  
  
  
  
  
  
  
  
  struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"
    
    var body: some WidgetConfiguration {
      IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
        WeatherWidgetEntryView()
      }
      .configurationDisplayName("Daily Weather")
      .description("The temperature changes every day")
      .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
  }
  
  
  
  
  
  
  
  struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
      SmallWeatherWidget(forecastListVM: CityForecastModel(), deviceLocationService: DeviceLocationService.shared, date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
        .previewContext(WidgetPreviewContext(family: .systemSmall))
      MediumWeatherWidget(forecastListVM: CityForecastModel(), deviceLocationService: DeviceLocationService.shared, date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
        .previewContext(WidgetPreviewContext(family: .systemMedium))
      LargeWeatherWidget(forecastListVM: CityForecastModel(), deviceLocationService: DeviceLocationService.shared, date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
        .previewContext(WidgetPreviewContext(family: .systemLarge))
      
    }
  }

