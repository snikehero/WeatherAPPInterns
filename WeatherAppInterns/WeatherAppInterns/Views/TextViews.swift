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

struct ExtraInfoHeader: View {
    var systemImage: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
            Text(title)
                .font(.headline)
        }
        .foregroundColor(.white)
    }
}

struct BigNumberText: View{
   var text: String
   var body: some View{
      Text(text)
         .font(Font.system(size: 90))
         .foregroundColor(.white)
         .fontWeight(.thin)
         .shadow(color: .black ,radius: 15, x: 2, y: 2)
         
   }
}

struct TitleText: View{
   var text: String
   var body: some View{
      Text(text)
           .foregroundColor(.white)
           .font(.title)
           .shadow(color: .black ,radius: 15, x: 2, y: 2)
   }
}

struct TitleTextCities: View{
   var text: String
   var body: some View{
      Text(text)
           .foregroundColor(.white)
           .font(.title)
           .fontWeight(.heavy)
   }
}

struct NormalText: View{
   var text:String
   var body: some View{
      Text(text)
           .font(.headline)
         .foregroundColor(.white)

   }
   
}

struct ButtonHeader: View {
    
    var text: String
    var systemImage: String
    
    var body: some View {
        Label(text, systemImage: systemImage)
            .font(.caption)
            .foregroundColor(.white)
            .opacity(0.60)
            .padding(.bottom, 1)
    }
}

struct ButtonTitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .foregroundColor(.white)
            .fontWeight(.medium)
    }
}

struct ButtonSubtitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.white)
            .fontWeight(.medium)
    }
}

struct ButtonDescription: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
    }
}

struct ExtraInfoTextBox: View {
    var text: String
    
    var body: some View {
        Text(text)
            .frame(maxWidth: 350)
            .multilineTextAlignment(.leading)
            .padding()
            .background(Color("ButtonFilledTextColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding([.trailing, .leading])
    }
}

struct CityWidget: View {
    var text: String
    
    var body: some View {
        Text(text)
        .font(.footnote)
        .fontWeight(.bold)
        .minimumScaleFactor(0.6)
        .foregroundColor(.white)
    }
}

struct BigTempWigdet: View {
    var text: String
    
    var body: some View {
        Text(text)
        .font(.system(size: 60, weight: .light))

      .minimumScaleFactor(0.6)
      .foregroundColor(.white)
    }
}

struct DescriptionWidget: View {
    var text: String
    
    var body: some View {
        Text(text)
      .font(.system(size: 11))
      .fontWeight(.semibold)
      .minimumScaleFactor(0.6)
      .foregroundColor(.white)
    }
}

struct ExtraInfoSection: View {
    var header: String
    var text: String
    
    var body: some View {
        VStack {
            NormalText(text: header)
                .padding(.top)
            ExtraInfoTextBox(text: text)
        }
    }
}

struct MaxMinWidget: View {
    var text: String
    
    var body: some View {
        Text(text)
        .font(.footnote)
        .fontWeight(.semibold)
        .minimumScaleFactor(0.6)
        .foregroundColor(.white)
    }
}


struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BackgroundColor")
            VStack {
              TitleText(text: "Aguascalientes")
              BigNumberText(text: "68")
              NormalText(text: "Mostly Sunny")
                ExtraInfoTextBox(text: "Today, the visibility will be perfectly clear, at 26 to 26km")

              ExtraInfoTextBox(text: "Today, the visibility will be perfectly clrear, at 26 to 26km")
                
                TitleTextCities(text: "Miami")

            }
        }

    }
}

