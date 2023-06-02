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
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

      let currentDate = Date()
           for dayOffset in 0 ..< 7 {
               let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
             let startOfDate = Calendar.current.startOfDay(for: entryDate)
               let entry = SimpleEntry(date: startOfDate, configuration: configuration)
               entries.append(entry)
           }

           let timeline = Timeline(entries: entries, policy: .atEnd)
           completion(timeline)
       }
   }

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct WeatherWidgetEntryView : View {
  @Environment(\.widgetFamily) var family
  var body: some View {
    
    if family == .systemSmall{
      SmallWeatherWidget(date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
    }
    if family == .systemMedium{
      MediumWeatherWidget(date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
    }
    if family == .systemLarge{
      LargeWeatherWidget(date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
    }
    }
  }



struct SmallWeatherWidget: View {
  
  @StateObject var forecastListVM = ForecastListViewModel()
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @StateObject private var dailyForecastListVM = DailyForecastListViewmodel()
  @State var coordinates: (lat: Double, lon: Double) = (0,0)
//  @State var tokens: Set<AnyCancellable> = []
  
//  @Binding var forecasts: [ForecastViewModel]
//  @Binding var dailyForecasts: [DailyForecastViewModel]
 
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
          CityWidget(text: city)
          BigTempWigdet(text: "\(String(temp.formatted()))°")
          Text(emoji)
            .font(.body)
          DescriptionWidget(text: description)
          MaxMinWidget(text: "Min:.\(String (tempMin.formatted()))°Max:.\(String (tempMax.formatted()))°")
        }
      } .padding()
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
  
  struct MediumWeatherWidget: View {
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
            
            CityWidget(text: city)
            Spacer()
            Text(emoji)
              .font(.body)
          }
          HStack{
            
            BigTempWigdet(text: "\(String(temp.formatted()))°")
            Spacer()
            
            VStack{
              DescriptionWidget(text: description)
              MaxMinWidget(text: "Min:.\(String (tempMin.formatted()))°Max:.\(String (tempMax.formatted()))°")
            }
          }
        }
        VStack{
          HStack(spacing: 28){
            ForEach(1..<7){ element in
              VStack(spacing: 3){
                Text(date)
                  .foregroundColor(.white)
                Text(emoji)
                Text("\(String(temp.formatted()))°")
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
              
              CityWidget(text: city)
              Spacer()
              Text(emoji)
                .font(.body)
            }
            HStack{
              
              BigTempWigdet(text: "\(String(temp.formatted()))°")
              
              Spacer()
              VStack(alignment: .trailing) {
                DescriptionWidget(text: description)
                
                MaxMinWidget(text: "Min:.\(String (tempMin.formatted()))°Max:.\(String (tempMax.formatted()))°")
              }
            }
          }
          Divider()
            .overlay(.white)
          
          VStack{
            HStack(spacing: 28){
              ForEach(1..<7){ element in
                VStack(spacing: 3){
                  Text(date)
                    .foregroundColor(.white)
                  Text(emoji)
                  Text("\(String(temp.formatted()))°")
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
                  Text(date)
                    .foregroundColor(.white)
                  Text(emoji)
                  Text("\(String(tempMin.formatted()))°")
                    .foregroundColor(.white)
                  Text("------------")
                    .foregroundColor(.white)
                  Text("\(String(tempMax.formatted()))°")
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
      SmallWeatherWidget(date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
      MediumWeatherWidget(date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
      LargeWeatherWidget(date: "27", temp: 23, emoji: "🌦️", city: "Mexico City", description: "Lloviendo", tempMax: 12, tempMin: 35)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
      
    }
}
