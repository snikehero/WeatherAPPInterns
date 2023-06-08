//
//  NetworkModel.swift
//  WeatherAppInterns
//
//  Created by Ulises Burns on 07/06/23.
//

import Foundation
import SwiftUI

//@main
struct WeatherApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
  

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(networkMonitor)
        }
    }
}

