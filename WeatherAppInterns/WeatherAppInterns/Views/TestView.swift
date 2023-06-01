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
   @State private var searchText = ""
   @State var tokens: Set<AnyCancellable> = []
    var body: some View {
        VStack {
           NavigationStack {
             Text("Searching for \(searchText)")
               .navigationTitle("Weather")
             NavigationLink {
                 EmptyView()
             } label: {
               CityView(forecasts: $forecastListVM.forecasts, city: $forecastListVM.city)
             }
           }
           .searchable(text: $searchText)
           .onAppear()
           {
             observeCoordinatesUpdates()
             observeLocationAccessDenied()
           }
           Button {
              isSheetPresented.toggle()
           } label: {
             Text("hola")
           }
        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
               
                     DemoView3()
                     
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
                        observeCoordinatesUpdates()
                        observeLocationAccessDenied()
                        deviceLocationService.requestLocationUpdates()
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
