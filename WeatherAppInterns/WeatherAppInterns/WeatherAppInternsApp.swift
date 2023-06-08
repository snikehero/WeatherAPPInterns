//
//  WeatherAppInternsApp.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 16/05/23.
//

import SwiftUI

@main
struct WeatherAppInternsApp: App {
  @StateObject var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            MainView()
            .environmentObject(networkMonitor)
        }
    }
}
