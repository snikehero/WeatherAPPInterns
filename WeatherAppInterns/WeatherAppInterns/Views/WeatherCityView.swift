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
  @StateObject var deviceLocationService = DeviceLocationService.shared
    @State var searchText = ""
    @State var temp = CityForecastModel()
    @State private var isPresented = false
    var body: some View{
        
        NavigationStack{
          ScrollView {
            VStack {
              Button {
                isPresented.toggle()
                
              } label: {
                VStack{
                  CityView(cities: $cityListVM.cities,citiesList: cityListVM )
                }
              }
              //                .fullScreenCover(isPresented: $isPresented, content: {
              //                    DemoView3()
              //                })
            }
            Spacer()
              .navigationTitle("Weather")
              .toolbarBackground(.visible, for: .navigationBar)
              .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
          }
            
        }
        
        .searchable(text: $searchText, prompt: "Search city or airport")
        .onSubmit(of: .search) {
            isSheetPresented.toggle()
        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                AddedCityView(cityName: searchText)
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
        }
    }
  
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCityView(temp: CityForecastModel.init())
      
    }
}
