//
//  NewCityView.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 08/06/23.
//

import SwiftUI
import Combine
import CoreLocation

struct NewCityView: View {
    var cityName : String
   @EnvironmentObject var cityListVM: CityListViewModel
   @EnvironmentObject var cityForecast: CityForecastModel
    var body: some View {

          ZStack {
             Color("BackgroundColor")
                .ignoresSafeArea()
                .opacity(50)
             
             VStack {
                Spacer()
                ScrollView (showsIndicators: false){
                   VStack (spacing: 10){
                      ZStack {
                         VStack {
                            ScrollView{
                               VStack {
                                  SummaryView()
                                   .environmentObject(cityForecast ?? CityForecastModel.init())
                                   ButtonSubtitle(text: cityForecast.forecasts.first?.overview ?? "overview")
                                     .shadow(color: .black ,radius: 15, x: 2, y: 2)
                                  HourlyView()
                                   .environmentObject(cityForecast ?? CityForecastModel.init())
                               }
                            }
                            .padding()
                         }
                        .onAppear(){
                          print(cityName)
                           cityForecast.getCityByName(cityName: cityName)
                         }
                      }
                   }
                }
             }
          }
       
    }
}

struct NewCityView_Previews: PreviewProvider {
    static var previews: some View {
        NewCityView(cityName: "Miami")
    }
}


