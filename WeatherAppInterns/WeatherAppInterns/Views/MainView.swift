//
//  MainView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 05/06/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
      TabView {
        ContentView()
          .tabItem{
            
            Label("", systemImage: "location")
              .font(.body.bold())
               .symbolVariant(.fill)
          }
        WeatherCityView()
          .tabItem {
            Label("", systemImage: "list.bullet")
              .font(.body.bold())
               .symbolVariant(.fill)
          }
      }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
