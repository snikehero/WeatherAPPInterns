//
//  ContentView.swift
//  WeatherApp
//
//  Created by Leo Avalos on 16/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       ScrollView{
          VStack {
             SummaryView()
             HourlyView()
             ForEach(1..<8) { row in
                DaysView(day: "Lunes", emoji: "☀️", minTemp: 12 , maxTemp: 31)

             }
          }
       }
        .padding()
        .background(.blue)
    }
}


struct SummaryView: View{
   var body: some View{
         VStack{
            TitleText(text: "Aguascalientes")
            BigNumberText(text: "68º")
            HStack{
               NormalText(text: "Min: 68")
               NormalText(text: "Max: 78")
            }
      }
         .background(.white)
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
      .background(.white)
   }
}

struct DaysView: View{
   
   var day: String
   var emoji: String
   var minTemp: Int
   var maxTemp: Int
   
   var body: some View{
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
      .background(.white)
   }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

