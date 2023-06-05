//
//  TestView.swift
//  WeatherAppInterns
//
//  Created by Leo Avalos on 31/05/23.
//

import SwiftUI
import CoreLocation
import Combine

struct WeatherCityView: View {
  //Seria WeatherCityView ya que vive todo aqui...
  @State private var isSheetPresented = false
  @StateObject var forecastListVM = CityForecastModel()
  @StateObject var cityListVM = CityListViewModel()
  @State var searchText = ""
   @State var temp = CityForecastModel()
  @State private var isPresented = false
  var body: some View {
    VStack {
      NavigationStack {
        Text("Searching for \(searchText)")
          .navigationTitle("Weather")
        NavigationLink {
          EmptyView()
        } label: {
//          CityView(arraycitis: $forecastListVM.forecasts,cityName: $forecastListVM.city)
          CityView(cities: $cityListVM.cities,citiesList: cityListVM)
          
          // 4.-Pasar CityForecastModel
        }
      }
      .searchable(text: $searchText)
      .onSubmit(of: .search) {
        isSheetPresented.toggle()
      }
    }
    .sheet(isPresented: $isSheetPresented) {
      ZStack {
        AddedCityView(cityName: searchText)
        EmptyView()
        VStack {
          HStack{
            Button(action: {
              isSheetPresented.toggle()
            }) {
              NormalText(text: "Cancel")
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            Spacer()
            Button {
              temp = forecastListVM.getCityByName(cityName: searchText)
              //forecastListVM.getCityByName(cityName: searchText)
              //Anadir el CityListViewModel 2.-
              cityListVM.addCity(cityToAdd: temp)
              
              isSheetPresented.toggle()
              
              
            } label: {
              NormalText(text: "Add")
            }
            .padding()
            
          }
          Spacer()
          
          
        }
        
      }
      .frame(maxWidth: .infinity)
      .background(Color.white)
      .edgesIgnoringSafeArea(.bottom)
    }
  }
  
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    WeatherCityView(temp: CityForecastModel.init())
  }
}
