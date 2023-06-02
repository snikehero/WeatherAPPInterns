//
//  CityView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 30/05/23.
//

import SwiftUI

struct CityView: View {
  @Binding var arraycitis: [ForecastViewModel]
  @Binding var cityName: [CityViewModel]
  var body: some View {
   
    ForEach(cityName, id: \.id) { element in
      VStack() {
        Text(element.cityName)
      }
    }
    ForEach($arraycitis, id: \.id) { element in
      VStack(spacing: 10) {
       
        VStack(alignment: .leading) {
          Text(element.wrappedValue.high)
            .font(.system(size: 30, weight: .medium, design: .rounded))
            .padding(.vertical, 5)
          
        
          
//
//          Text(element.wrappedValue.current)
//            .font(.system(size: 20, weight: .regular, design: .rounded))
//            .padding(.vertical, 5)
//          
//          Text(element.wrappedValue.current)
//            .font(.system(size: 16, weight: .regular, design: .rounded))
//            .padding(.vertical, 5)
        }
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
