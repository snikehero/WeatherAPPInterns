//
//  TextViews.swift
//  WeatherApp
//
//  Created by Leo Avalos on 16/05/23.
//

import SwiftUI

struct TextViews: View {
   var text: String
    var body: some View {
      Text(text)
          .bold()
    }
}

struct BigNumberText: View{
   var text: String
   var body: some View{
      Text(text)
         .font(Font.system(size: 90))
         .fontWeight(.light)
         
   }
}

struct TitleText: View{
   var text: String
   var body: some View{
      Text(text)
         .font(Font.system(size: 28))
   }
}

struct NormalText: View{
   var text:String
   var body: some View{
      Text(text)
         .font(Font.system(size: 18))
         .foregroundColor(.black)
   }
   
}



struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
       VStack {
          TitleText(text: "Aguascalientes")
          BigNumberText(text: "68")
          NormalText(text: "Mostly Sunny")
          
          
       }

    }
}

