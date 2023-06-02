//
//  AddedCityView.swift
//  WeatherAppInterns
//
//  Created by Leo Avalos on 01/06/23.
//

import SwiftUI
import Combine
import CoreLocation


struct AddedCityView: View {
   var cityName : String
   @StateObject var forecastListVM = CityForecastModel()
   @StateObject var deviceLocationService = DeviceLocationService.shared
   @State var tokens: Set<AnyCancellable> = []
   @State var coordinates: (lat: Double, lon: Double) = (0,0)
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
                                 SummaryView(forecasts: $forecastListVM.forecasts,cityName: forecastListVM.city.cityName)
                                 ButtonSubtitle(text: forecastListVM.forecasts.first?.overview ?? "overview")
                                    .shadow(color: .black ,radius: 15, x: 2, y: 2)
                                 //HourlyView(forecasts: $forecastListVM.forecasts)
                              }
                           }
                           .padding()
                        }
                        .onAppear(){
                           forecastListVM.getCityByName(cityName: cityName)
                        }
                     }




                  }
                  
               }

            }
         
         }
      }
   }
   
   func observeCoordinatesUpdates()
   {
      deviceLocationService.coordinatesPublisher
         .receive(on: DispatchQueue.main)
         .sink {completion in
            if case .failure (let error) = completion {
               print(error)
            }
         } receiveValue: { coordinates in
            self.coordinates = (coordinates.latitude, coordinates.longitude)
            forecastListVM.coordinates = (coordinates.latitude, coordinates.longitude)
            forecastListVM.getWeatherForecast()
            forecastListVM.getCity()
            forecastListVM.location = "location"

         }
         .store(in: &tokens)
   }
   func observeLocationAccessDenied() {
      deviceLocationService.deniedLocationAccessPublisher
         .receive(on: DispatchQueue.main)
         .sink {
            print("Show some kind of alert to the user")
            self.coordinates = (37.3230,-122.0322)
            forecastListVM.getWeatherForecast()
            forecastListVM.getCity()
            forecastListVM.location = "location"


         }
         .store(in: &tokens)
   }
   
}


struct AddedCityView_Previews: PreviewProvider {
   static var previews: some View {
      AddedCityView(cityName: "Miami")
   }
}
