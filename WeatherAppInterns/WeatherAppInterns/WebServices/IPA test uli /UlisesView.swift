//
//  UlisesView.swift
//  WeatherAppInterns
//
//  Created by Ulises Burns on 16/05/23.
//

import SwiftUI

struct UlisesView: View {
  
  @ObservedObject var viewModel : WeatherViewModel
  
  var body: some View {
    VStack(){
      Text(viewModel.cityname)
        .font(.largeTitle)
        .padding()
      Text(viewModel.temperature)
        .font(.system(size: 70))
        .bold()
      Text (viewModel.weatherIcon)
        .font(.largeTitle)
        .padding()
      Text(viewModel.weatherDescription)
      Text(viewModel.windSpeed.formatted())
      Text(viewModel.tempMin)
      Text(viewModel.tempMax)
    }.onAppear(perform: viewModel.refresh)
  }
  
  struct UlisesView_Previews: PreviewProvider {
    static var previews: some View {
      UlisesView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
  }
}
