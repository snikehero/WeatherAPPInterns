//
//  CityView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 30/05/23.
//

import SwiftUI

struct CityView: View {
   var cont: Int
  @Binding var arrayOfCities: [ForecastListViewModel]
  var body: some View {
    ForEach(arrayOfCities, id: \.id) { element in
      VStack(alignment: .leading) {
        Text(element.city.cityName)
          .font(.system(size: 30, weight: .medium, design: .rounded))
          .padding(.vertical, 5)
        
        Text(element.forecasts.first?.current ?? "0")
          .font(.system(size: 20, weight: .regular, design: .rounded))
          .padding(.vertical, 5)
        
        Text(element.forecasts.first?.day ?? "0")
          .font(.system(size: 16, weight: .regular, design: .rounded))
          .padding(.vertical, 5)
      }
    }
  }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
      //CityView(city: ForecastViewModel.mock)
      Text("Preview")
    }
}
