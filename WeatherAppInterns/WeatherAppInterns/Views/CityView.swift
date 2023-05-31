//
//  CityView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 30/05/23.
//

import SwiftUI

struct CityView: View {
  @Binding var forecasts: [ForecastViewModel]
  @Binding var city: CityViewModel
    var body: some View {
        VStack(alignment: .leading) {
          Text(city.cityName)
                .font(.system(size: 30, weight: .medium, design: .rounded))
                .padding(.vertical, 5)

          Text(forecasts.first?.clouds ?? "0")
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .padding(.vertical, 5)

          Text(forecasts.first?.current ?? "0")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .padding(.vertical, 5)
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
      //CityView(city: ForecastViewModel.mock)
      Text("Preview")
    }
}
