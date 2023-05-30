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
  var body: some View {
    

    ZStack {
      ContainerRelativeShape()
        .fill(Color.blue.opacity(0.6))
        .shadow(color: .black ,radius: 15, x: 2, y: 2)
      
      VStack{
        
          VStack(alignment: .leading, spacing: 4) {
            Text("Ciudad de mexico")
              .font(.footnote)
              .fontWeight(.bold)
              .minimumScaleFactor(0.6)
              .foregroundColor(.white)
            Text("27°")
              .font(.system(size: 60, weight: .light))

              .minimumScaleFactor(0.6)
              .foregroundColor(.white)
            Text("🌦️")
              .font(.body)
            Text("Parcialmente Nublado")
              .font(.system(size: 11))
              .fontWeight(.semibold)
              .minimumScaleFactor(0.6)
              .foregroundColor(.white)
            Text("Max.: 25° Min.:20°")
              .font(.footnote)
              .fontWeight(.semibold)
              .minimumScaleFactor(0.6)
              .foregroundColor(.white)   
        }
      }
      .padding()
    }
  }
}





struct SmallWeatherWidget: View {
  var body: some View {
    ZStack {
      ContainerRelativeShape()
        .fill(Color.blue.opacity(0.6))
        .shadow(color: .black ,radius: 15, x: 2, y: 2)
      
      VStack{
          VStack(alignment: .leading, spacing: 4) {
            Text("Ciudad de mexico")
              .font(.footnote)
              .fontWeight(.bold)
              .minimumScaleFactor(0.6)
              .foregroundColor(.white)
            Text("27°")
              .font(.system(size: 60, weight: .light))

              .minimumScaleFactor(0.6)
              .foregroundColor(.white)
            Text("🌦️")
              .font(.body)
            Text("Parcialmente Nublado")
              .font(.system(size: 11))
              .fontWeight(.semibold)
              .minimumScaleFactor(0.6)
              .foregroundColor(.white)
            Text("Max.: 25° Min.:20°")
              .font(.footnote)
              .fontWeight(.semibold)
              .minimumScaleFactor(0.6)
              .foregroundColor(.white)
        }
      }
      .padding()
    }
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
              
              Text(city)
                .font(.footnote)
                .fontWeight(.bold)
                .minimumScaleFactor(0.6)
                .foregroundColor(.white)
                Spacer()
              Text(emoji)
                .font(.body)
            }
            HStack{
              
              Text("\(String(temp.formatted()))°")
                .font(.system(size: 30, weight: .light))
                .foregroundColor(.white)
              Spacer()
              
              VStack{
                Text(description)
                  .font(.system(size: 11))
                  .fontWeight(.semibold)
                  .minimumScaleFactor(0.6)
                  .foregroundColor(.white)
                Text("Max.: \(String(tempMin.formatted()))° Min.\(String(tempMax.formatted()))°")
                  .font(.footnote)
                  .fontWeight(.semibold)
                  .minimumScaleFactor(0.6)
                  .foregroundColor(.white)
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
            
            Text(city)
              .font(.footnote)
              .fontWeight(.bold)
              .minimumScaleFactor(0.6)
              .foregroundColor(.white)
            Spacer()
            Text(emoji)
              .font(.body)
          }
          HStack{
            
            Text("\(String(temp.formatted()))°")
              .font(.system(size: 30, weight: .light))
              .foregroundColor(.white)
            
            Spacer()
            VStack(alignment: .trailing) {
              Text(description)
                .font(.system(size: 11))
                .fontWeight(.semibold)
                .minimumScaleFactor(0.6)
                .foregroundColor(.white)
              
              Text("Max.: \(String(tempMin.formatted()))° Min.\(String(tempMax.formatted()))°")
                .font(.footnote)
                .fontWeight(.semibold)
                .minimumScaleFactor(0.6)
                .foregroundColor(.white)
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
      SmallWeatherWidget()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
      MediumWeatherWidget(date: "27", temp: 23, emoji: "🌦️", city: "Aguascalientes", description: "Parcialmente Nublado", tempMax: 12, tempMin: 35)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
      LargeWeatherWidget(date: "27", temp: 23, emoji: "🌦️", city: "Mexico City", description: "Lloviendo", tempMax: 12, tempMin: 35)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
      
    }
}
