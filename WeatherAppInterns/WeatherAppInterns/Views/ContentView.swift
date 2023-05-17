//
//  ContentView.swift
//  WeatherApp
//
//  Created by Leo Avalos on 16/05/23.
//

import SwiftUI

struct ContentView: View {
   var body: some View {
      ZStack{
         VStack {
            ScrollView{
               VStack {
                  SummaryView(city: "Aguascalientes", actTemp: 28, minTemp: 12, maxTemp: 32)
                  HourlyView()
                  VStack(spacing: 10){
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
         .background(Color("BackgroundColor"))
         }
         NavBarView()
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
               NormalText(text: "Min: \(String(minTemp))")
               NormalText(text: "Max: \(String(maxTemp))")
            }
      }

   }
}

struct HourlyView: View{
   var body: some View{
      VStack{
        NormalText(text: "Cielos parcialmente numblados Lorem ipsum dolor sit amet")
            ScrollView(.horizontal){
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

