//
//  TestView.swift
//  WeatherAppInterns
//
//  Created by Leo Avalos on 31/05/23.
//

import SwiftUI
import CoreLocation
import Combine

struct CreateCityView: View {
    
    //Seria WeatherCityView ya que vive todo aqui...
    @State private var isSheetPresented = false
    //@StateObject var forecastListVM = CityForecastModel()
    @EnvironmentObject var cityListVM: CityListViewModel
    // @StateObject var forecastListVM = CityForecastModel()
    @StateObject var deviceLocationService = DeviceLocationService.shared
    @State var searchText = ""
    @State var temp = CityForecastModel()
    @State private var isPresented = false
    @State private var counter = 0
    var body: some View{
        NavigationStack{
          ScrollView {
            VStack {
              //Picker para cambiar entre centigrados y fahrenheit
              Picker(selection: $cityListVM.cities.first?.forecasts.first?.system  ?? .constant(CityForecastModel.init().system), label: Text("System")) {
                Text("ºC").tag(0)
                Text("ºF").tag(1)
              }
              .pickerStyle(SegmentedPickerStyle())
              .frame(width:100)
//              Button {
//                isPresented.toggle()
//              } label: {
//                VStack{
//                  CityCardView()
//                    .environmentObject(cityListVM)
//                }
              
              
                ForEach(cityListVM.cities, id: \.id ) { element in
                  Button {
                    isPresented.toggle()
                    WeatherView()
                      .environmentObject(element)
                  } label: {
                    VStack{
                      CityCardView()
                        .environmentObject(element)
                    }
                  }

              }
              
              
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
          cityListVM.addCity(cityToAdd: cityListVM.cities.last?.getCityByName(cityName: searchText) ?? CityForecastModel.init())

        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                NewCityToAdd(cityName: searchText)
                .environmentObject(cityListVM)
                VStack {
                    HStack{
                        Button(action: {
                            isSheetPresented.toggle()
                          cityListVM.removeCity()
                        }) {
                            NormalText(text: "Cancel")
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        Spacer()
                        Button {
                          print(cityListVM.cities.count)
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

struct CreateCityView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCityView(temp: CityForecastModel.init())
            .environmentObject(CityListViewModel())
      
    }
}
