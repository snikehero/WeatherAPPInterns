//
//  DataView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 17/05/23.
//

import SwiftUI
import Combine
struct DataView: View {
  @StateObject private var forecastListVM = ForecastListViewModel()
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @State var tokens: Set<AnyCancellable> = []
  @State var coordinates: (lat: Double, lon: Double) = (0,0)
    var body: some View {
    NavigationView {
      VStack{
          Button {
            forecastListVM.getWeatherForecast()
           forecastListVM.getCity()
         } label: {
            Image(systemName: "magnifyingglass.circle.fill")
             .font(.title3)
         }
        Text(forecastListVM.city)
        List(forecastListVM.forecasts, id: \.day) { day in
            VStack(alignment: .leading){
              Text(day.day)
                .fontWeight(.bold)
              HStack(alignment: .top)
              {
                Image(systemName: "hourglass")
                  .font(.title)
                  .frame(width: 50, height: 50)
                  .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                VStack(alignment: .leading)
                {
                  Text(day.day)
                  Text(day.high)
                  Text(day.low)
                  Text(day.fellsLike)
                  Text(day.pressure)
                  Text(day.humidity)
                  Text(day.weatherDescription)
                  Text(day.clouds)
                  Text(day.windSpeed)
                  HStack {
                    Text(day.precipitation)
                    Text(day.windGust)
                    Text(day.windDeg)
                  }
                  


                }
                
              }
            }
          }
          .listStyle(PlainListStyle())
      }
      .padding(.horizontal)
      .navigationTitle("Mobile Weather")
    }.onAppear()
      {
        observeCoordinatesUpdates()
        observeLocationAccessDenied()
        deviceLocationService.requestLocationUpdates()
       
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
       }
       .store(in: &tokens)
   }
   
   func observeLocationAccessDenied() {
     deviceLocationService.deniedLocationAccessPublisher
       .receive(on: DispatchQueue.main)
       .sink {
         print("Show some kind of alert to the user")
       }
       .store(in: &tokens)
   }
}

struct DataView_Previews: PreviewProvider {
  static var previews: some View {
    DataView()
  }
}
