//
//  WelcomeView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 16/05/23.
//
import CoreLocationUI
import SwiftUI

struct WelcomeView: View {
  @ObservedObject var viewModel : WeatherViewModel
 
  var body: some View {
    VStack {
      Text("Datos recabados de la API")
        .font(.title)
      Text("Nombre de la ciudad: \(viewModel.cityname)")
      Text("Temperatura: \(viewModel.temperature)")
      Text("Temperatura Minima: \(viewModel.tempMin)")
      Text("Temperatura Maxima: \(viewModel.tempMax)")
      Text("Humedad: \(viewModel.humidity)")
      Text("Presion Atmosferica: \(viewModel.pressure)")
      Text("Velocidad del viento: \(viewModel.windSpeed)")
      Text("Descripcion del clima: \(viewModel.weatherDescription)")
      Text("Icono: \(viewModel.weatherIcon)")
    }.onAppear(perform: viewModel.refresh)
  }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
