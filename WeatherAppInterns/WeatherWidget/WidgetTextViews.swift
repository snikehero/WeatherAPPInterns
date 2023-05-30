//
//  WidgetTextViews.swift
//  WeatherAppInterns
//
//  Created by Ulises Burns on 29/05/23.
//

import SwiftUI

struct WidgetTextViews: View {
  var body: some View {
    VStack{
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      BigTempText(text: "38")
      WidgetText(text: "Hola")
    } .background(Color(.black))
  }
}

struct BigTempText: View{
   var text: String
   var body: some View{
      Text(text)
         .font(Font.system(size: 60))
         .foregroundColor(.white)
         .fontWeight(.thin)
         .shadow(color: .black ,radius: 15, x: 2, y: 2)
         
   }
}

struct WidgetText: View{
   var text:String
   var body: some View{
      Text(text)
           .font(.headline)
         .foregroundColor(.white)

   }
   
}

struct WidgetTextViews_Previews: PreviewProvider {
    static var previews: some View {
        WidgetTextViews()
    }
}

