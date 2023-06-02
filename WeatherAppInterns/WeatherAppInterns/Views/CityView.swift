//
//  CityView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 30/05/23.
//

import SwiftUI

struct CityView: View {
  @Binding var arraycitis: [ForecastViewModel]
  @Binding var cityName: CityViewModel
  //Cambiar para recibir CityForecastModel
  var body: some View {
   
    List {
     
        VStack() {
          Text(cityName.cityName)
        
      }
      ForEach($arraycitis, id: \.id) { element in
        VStack(spacing: 10) {
         
          VStack(alignment: .leading) {
            Text(element.wrappedValue.high)
              .font(.system(size: 30, weight: .medium, design: .rounded))
              .padding(.vertical, 5)
            
          }
        }
      }
    }
  }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
      CityView(arraycitis: .constant([ForecastViewModel.mock]), cityName: .constant(.mock))      //Text("Preview")
    }
}
