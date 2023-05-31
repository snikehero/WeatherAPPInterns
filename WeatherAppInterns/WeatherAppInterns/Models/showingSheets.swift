//
//  showingSheets.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 29/05/23.
//

import Foundation

enum showingSheets : String, CaseIterable, Identifiable{
    var id: Self {
      return self
    }
    
    case precipitation, visibility, wind, uvIndex, feelsLike, humidity, pressure, airQuality
}
