//
//  AngelView.swift
//  WeatherAppInterns
//
//  Created by Leo Avalos on 16/05/23.
//

import SwiftUI

struct AngelView: View {
    var body: some View {
       ZStack {
          VStack {
               ScrollView{
                  VStack {
                     SummaryView(city: "Aguascalientes", actTemp: 28, minTemp: 12, maxTemp: 32)
                      ButtonSubtitle(text: "Mostly Sunny")
                          .shadow(color: .black ,radius: 15, x: 2, y: 2)
                     HourlyView()
                      VStack(alignment: .leading, spacing: 10){
                         ButtonHeader(text: "10 - DAY FORECAST", systemImage: "calendar")
                         HeaderDivider()
                         
                        ForEach(1..<8) { row in
                           DaysView(day: "Lunes", emoji: "☀️", minTemp: 12 , maxTemp: 31)
                           
                        }
                     }
                     .padding()
                     .background(Color("ButtonColor"))
                     .clipShape(RoundedRectangle(cornerRadius: 15))
                  }
               }
               .padding()
          }
          //NavBarView()
       }
      
   }
   
}


struct SummaryView: View{
   var city: String
   var actTemp: Int
   var minTemp: Int
   var maxTemp: Int
   
   var body: some View{
         VStack{
            TitleText(text: city)
            BigNumberText(text: "\(String(actTemp))º")
            HStack{
               ButtonSubtitle(text: "H: \(String(minTemp))º")
                    .shadow(color: .black ,radius: 15, x: 2, y: 2)
               ButtonSubtitle(text: "L: \(String(maxTemp))º")
                    .shadow(color: .black ,radius: 15, x: 2, y: 2)
            }
      }

   }
}

struct HourlyView: View{
   var body: some View{
      VStack{
        ButtonDescription(text: "Cloudy conditions will continue for the rest of the day. Wind gusts are up tp 20 km/h ")
          HeaderDivider()
            ScrollView(.horizontal, showsIndicators: false){
                  HStack{
                     ForEach(1..<25) { element in
                        VStack(spacing: 10) {
                           NormalText(text: String(element))
                           NormalText(text: "☀️")
                           NormalText(text: "Temp")
                        }
                  }
               }
         }
      }
      .padding()
      .background(Color("ButtonColor"))
      .clipShape(RoundedRectangle(cornerRadius: 15))
   }
}

struct DaysView: View{
   
   var day: String
   var emoji: String
   var minTemp: Int
   var maxTemp: Int
   
   var body: some View{
      VStack{
         Button {
         } label: {
            HStack{
               NormalText(text: day)
               Spacer()
               NormalText(text: emoji)
               Spacer()
               NormalText(text: String(minTemp))
               Spacer()
               NormalText(text: "------")
               Spacer()
               NormalText(text: String(maxTemp))
            }
         }
      }
      .background(Color("ButtonColor"))
    }
}

struct AngelView_Previews: PreviewProvider {
    static var previews: some View {
        AngelView()
            .background(Color("BackgroundColor"))
    }
}
