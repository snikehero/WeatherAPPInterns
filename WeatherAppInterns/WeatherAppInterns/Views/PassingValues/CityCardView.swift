//
//  CityView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 30/05/23.
//

import SwiftUI

struct CityCardView: View {
  //@EnvironmentObject var cities: CityListViewModel
  @EnvironmentObject var city: CityForecastModel
  var body: some View {
   
    //New2
    
    //ForEach(cities.cities, id: \.id) { element in
          VStack{
          
              HStack{
                TitleTextCities(text: city.city.cityName )
                  Spacer()
                BigTempWigdet(text: "\(city.forecasts.first?.current ?? "0") º" )
              }
              .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
              HStack{
                  NormalText(text:"Summary")
                  Spacer()
                NormalText(text: "H: \(city.forecasts.first?.high ?? "0") º")
                NormalText(text: "L: \(city.forecasts.first?.low ?? "0") º")
              }
              .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))


          }
          .background(Color("BackgroundColor"))
          .ignoresSafeArea()
          .clipShape(RoundedRectangle(cornerRadius: 15))
          .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
       // }
      Spacer()
  }
}

struct CityCardView_Previews: PreviewProvider {
    static var previews: some View {
      CityCardView()
      
    }
}
