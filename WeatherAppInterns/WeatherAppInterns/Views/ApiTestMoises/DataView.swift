//
//  DataView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 17/05/23.
//

import SwiftUI

struct DataView: View {
  @StateObject private var forecastListVM = ForecastListViewModel()
    var body: some View {
    NavigationView {
      VStack{


        HStack {
          TextField("Enter Location", text: $forecastListVM.location)
            .textFieldStyle(RoundedBorderTextFieldStyle())
          Button {
            forecastListVM.getWeatherForecast()
            forecastListVM.getCity()
          } label: {
            Image(systemName: "magnifyingglass.circle.fill")
              .font(.title3)
          }
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
                  


                }
              }
            }
          }
          .listStyle(PlainListStyle())
      }
      .padding(.horizontal)
      .navigationTitle("Mobile Weather")
    }
  }
}

struct DataView_Previews: PreviewProvider {
  static var previews: some View {
    DataView()
  }
}
