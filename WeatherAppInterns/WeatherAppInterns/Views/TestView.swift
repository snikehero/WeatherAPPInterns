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
   @State var cont = 0
   @State private var isSheetPresented = false
   @StateObject var forecastListVM = ForecastListViewModel()
   @StateObject var deviceLocationService = DeviceLocationService.shared
   @State var searchText = ""
   @State var tokens: Set<AnyCancellable> = []
    @State var arrayOfCities = Array<ForecastListViewModel>()
    var body: some View {
        VStack {
           NavigationStack {
             Text("Searching for \(searchText)")
               .navigationTitle("Weather")
             NavigationLink {
                 EmptyView()
             } label: {
               CityView(cont: cont, arrayOfCities: $arrayOfCities)
             }
           }
           .searchable(text: $searchText)
          
           Button {
              isSheetPresented.toggle()
             forecastListVM.getCityByName(cityName: searchText)
             cityArray(forecast: forecastListVM)
           } label: {
             Text("hola")
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

//                        observeCoordinatesUpdates()
//                        observeLocationAccessDenied()
//                        deviceLocationService.requestLocationUpdates()
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
   

  func cityArray(forecast: ForecastListViewModel){
     arrayOfCities.append(forecast)
    print(arrayOfCities)
      cont += 1
    print("Se anadio \(arrayOfCities.first?.city.cityName)")
    
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
