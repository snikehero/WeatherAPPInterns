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
          
//          Text("")
//            .font(.system(size: 80,weight: .heavy))
//            .foregroundColor(config.dayTextColor)
        
      }
      .padding()
    }
     // Text(entry.date, style: .time)
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
          
//          Text("")
//            .font(.system(size: 80,weight: .heavy))
//            .foregroundColor(config.dayTextColor)
        
      }
      .padding()
    }
     // Text(entry.date, style: .time)
  }
  
  
}

struct MediumWeatherWidget: View {
  var body: some View {
    ZStack {
      ContainerRelativeShape()
        .fill(Color.blue.opacity(0.6))
        .shadow(color: .black ,radius: 15, x: 2, y: 2)
      
      VStack{
          VStack(alignment: .leading, spacing: 4) {
            HStack(){
              Text("Ciudad de mexico")
                .font(.footnote)
                .fontWeight(.bold)
                .minimumScaleFactor(0.6)
                .foregroundColor(.white)
              Text("🌦️")
                .font(.body)
            }
            HStack{
              Text("27°")
                .font(.system(size: 60, weight: .light))
              
                .minimumScaleFactor(0.6)
                .foregroundColor(.white)
              VStack{
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
          
        }
          
//          Text("")
//            .font(.system(size: 80,weight: .heavy))
//            .foregroundColor(config.dayTextColor)
        
      }
      .padding()
    }
     // Text(entry.date, style: .time)
  }
  
  
}

struct LargeWeatherWidget: View {
  var body: some View {
    ZStack {
      ContainerRelativeShape()
        .fill(Color.blue.opacity(0.6))
        .shadow(color: .black ,radius: 15, x: 2, y: 2)
      
      VStack(alignment: .leading, spacing: 10){
        
        Text("Lunes       🌦️        13 --------- 23  ")
          .font(.footnote)
          .fontWeight(.bold)
          .minimumScaleFactor(0.6)
          .foregroundColor(.white)
        Text("Martes      🌦️        13 --------- 23  ")
          .font(.footnote)
          .fontWeight(.bold)
          .minimumScaleFactor(0.6)
          .foregroundColor(.white)
        Text("Miercoles  🌦️        13 --------- 23  ")
          .font(.footnote)
          .fontWeight(.bold)
          .minimumScaleFactor(0.6)
          .foregroundColor(.white)
        Text("Jueves      🌦️        13 --------- 23  ")
          .font(.footnote)
          .fontWeight(.bold)
          .minimumScaleFactor(0.6)
          .foregroundColor(.white)
        Text("Viernes     🌦️        13 --------- 23  ")
          .font(.footnote)
          .fontWeight(.bold)
          .minimumScaleFactor(0.6)
          .foregroundColor(.white)
        
        
      }.padding()
      
      
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
      MediumWeatherWidget()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
      LargeWeatherWidget()
            .previewContext(WidgetPreviewContext(family: .systemLarge))
      
    }
}
