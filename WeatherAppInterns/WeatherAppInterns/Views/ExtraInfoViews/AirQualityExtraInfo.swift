//
//  AirQualityExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 30/05/23.
//

import SwiftUI

struct AirQualityExtraInfo: View {
  @Binding var isShowing : Bool
  @Binding var airQuality: [AirPollutionViewModel]
  @State private var selectedTab = 0
   var aqiIndex = 0
  var body: some View {
    NavigationStack{
      ZStack{
        Color("ExtraInfoBackgroundColor")
          .ignoresSafeArea()
        
        VStack {
          ScrollView {
            VStack {
              HStack {
                MapView()
              }
              .frame(width: 300, height: 300)
              .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
              
              ExtraInfoSection(header: airQuality.first?.airPollutionDescription ?? "0", text: "Air Quality Index is \(airQuality.first?.index ?? "0"), which is similar to yesterday at about this time.")
              AirQualitySlider(value: airQuality.first?.index ?? "0")
              ExtraInfoSection(header: "Healh Information", text: airQuality.first?.airPollutionHealth ?? "0")
              ExtraInfoSection(header: "Primary Pollutant", text: AboutConstants.airQuality.rawValue)
            }
            .foregroundColor(.white)
          }
        }
        
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          ExtraInfoHeader(systemImage: airQuality.first?.aqiIcon ?? "aqi.low", title: "Air Quality")
        }
        ToolbarItem(placement: .primaryAction) {
          Button{
            isShowing.toggle()
          } label: {
            XMarkButton()
          }
        }
      }
    }
    
  }
}

struct AirQualityExtraInfo_Previews: PreviewProvider {
  static var previews: some View {
    let isShowing = Binding.constant(false)
    //AirQualityExtraInfo(isShowing: isShowing, aqiIndex: 0)
    Text("Preview")
  }
}
