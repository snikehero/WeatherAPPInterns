//
//  AddedCityView.swift
//  WeatherAppInterns
//
//  Created by Leo Avalos on 01/06/23.
//

import SwiftUI
import Combine
import CoreLocation


struct NewCityToAdd: View {
   var cityName : String
   //@StateObject var forecastListVM = CityForecastModel()
  @EnvironmentObject var cityListVM: CityListViewModel
   var body: some View {
      NavigationStack {
         ZStack {
            //BackgroundView()x
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
                                  .environmentObject(cityListVM.cities.last ?? CityForecastModel.init())
                                 //ButtonSubtitle(text: forecastListVM.forecasts.first?.overview ?? "overview")
                                  ButtonSubtitle(text: cityListVM.cities.last?.forecasts.first?.overview ?? "overview")
                                    .shadow(color: .black ,radius: 15, x: 2, y: 2)
                                 HourlyView()
                                  .environmentObject(cityListVM.cities.last ?? CityForecastModel.init())
                              }
                           }
                           .padding()
                        }
                       .onAppear(){
                         print(cityName)
                          //forecastListVM.getCityByNameCityView(cityName: cityName)
                          cityListVM.cities.last?.getCityByName(cityName: cityName)
                        //cityListVM.cities.last?.getCityByNameCityView(cityName: cityName)
                        }
                     }
                  }
               }
            }     
         }
      }
   }
}


struct NewCityToAdd_Previews: PreviewProvider {
   static var previews: some View {
      NewCityToAdd(cityName: "Miami")
   }
}
