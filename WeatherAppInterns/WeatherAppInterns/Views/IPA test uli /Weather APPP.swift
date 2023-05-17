//
//  Weather APPP.swift
//  WeatherAppInterns
//
//  Created by Ulises Burns on 17/05/23.
//

import SwiftUI

@main
struct WeatherApp: App {
  var body: some Scene{
    WindowGroup{
      UlisesView(viewModel: WeatherViewModel(weatherService: WeatherService()))
      
    }
  }
}
