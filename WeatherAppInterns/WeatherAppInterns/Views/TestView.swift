//
//  TestView.swift
//  WeatherAppInterns
//
//  Created by Leo Avalos on 31/05/23.
//

import SwiftUI
import CoreLocation
import Combine

struct TestView: View {
   @State private var isSheetPresented = false
  @StateObject var forecastListVM = ForecastListViewModel()
   @StateObject var deviceLocationService = DeviceLocationService.shared
   @State var searchText = ""
   @State var tokens: Set<AnyCancellable> = []
  @State var arrayCitis = [ForecastViewModel]()
  @State var arrayNames = [CityViewModel]()
    var body: some View {
        VStack {
           NavigationStack {
             Text("Searching for \(searchText)")
               .navigationTitle("Weather")
             NavigationLink {
                 EmptyView()
             } label: {
               CityView(arraycitis: $arrayCitis,cityName: $arrayNames)
             }
           }
           .searchable(text: $searchText)
          
           Button {
              isSheetPresented.toggle()
             cityArray(forecast: forecastListVM.forecasts.first ?? ForecastViewModel.mock)
             cityArrayNames(cityName: forecastListVM.city)
           } label: {
             Text("Buscar Ciudad")
           }
        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
               AddedCityView(cityName: searchText)
               VStack {
                  HStack{
                     Button(action: {
                        isSheetPresented.toggle()
                     }) {
                        NormalText(text: "Cancel")
                           .foregroundColor(.white)
                           .cornerRadius(10)
                     }
                     .padding()
                     Spacer()
                     Button {
                        forecastListVM.getCityByName(cityName: searchText)
                     
                        isSheetPresented.toggle()
                     
                       
                     } label: {
                        NormalText(text: "Add")
                     }
                     .padding()
                     
                  }
                  Spacer()

                        
               }

            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
   

   func cityArray(forecast: ForecastViewModel){
     arrayCitis.append(forecast)
   }
  func cityArrayNames(cityName: CityViewModel)
  {
    arrayNames.append(cityName)
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
          forecastListVM.getCityByName(cityName: searchText)
//         forecastListVM.getWeatherForecast()
//         forecastListVM.getCity()
//         forecastListVM.location = "location"
       }
       .store(in: &tokens)
   }
   func observeLocationAccessDenied() {
     deviceLocationService.deniedLocationAccessPublisher
       .receive(on: DispatchQueue.main)
       .sink {
         print("Show some kind of alert to the user")
          forecastListVM.getCityByName(cityName: "Cupertino")
//         forecastListVM.getWeatherForecast()
//         forecastListVM.getCity()
//         forecastListVM.location = "location"
       }
       .store(in: &tokens)
   }
   
 
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
