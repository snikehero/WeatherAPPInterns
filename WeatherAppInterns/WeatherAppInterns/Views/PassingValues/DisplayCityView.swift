//
//  DisplayCityView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 08/06/23.
//

import SwiftUI
//NewCityView(cityName: "")
//    .environmentObject(cityListVM)
//    .environmentObject(cityListVM.cities.first? ?? CityForecastModel.init()
struct DisplayCityView: View {
  @EnvironmentObject var cityListVM: CityListViewModel
  @State private var selectedTab = 0
  @State private var index = 0
  var body: some View {
    //NavigationStack {
    ZStack {
      TabView(selection: $selectedTab) {
        ForEach(Array(cityListVM.cities.enumerated()),id : \.offset){ index,city in
          NewCityView(cityName: "")
            .environmentObject(cityListVM)
            .environmentObject(city)
            .tabItem {
              Label(city.city.cityName,systemImage: "1.circle")
            }
            .tag(index)
        }
      }
      .tabViewStyle(.page)
    }
    .ignoresSafeArea(.container, edges: .top)
  }
}

struct DisplayCityView_Previews: PreviewProvider {
  static var previews: some View {
    //DisplayCityView()
    Text("Hello there")
  }
}
