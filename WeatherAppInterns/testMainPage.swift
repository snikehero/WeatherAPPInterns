//
//  testMainPage.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 08/06/23.
//

import SwiftUI
import CoreLocation
import Combine

struct testMainPage: View {
    
    //Seria WeatherCityView ya que vive todo aqui...
    @State private var isSheetPresented = false
    @EnvironmentObject var cityListVM: CityListViewModel
    // @StateObject var forecastListVM = CityForecastModel()
    @StateObject var deviceLocationService = DeviceLocationService.shared
    @State var searchText = ""
    @State var temp = CityForecastModel()
    @State private var isPresented = false
    @State private var counter = 0
    var body: some View{
        NavigationStack{
            VStack {
                //Picker para cambiar entre centigrados y fahrenheit
                Picker(selection: $cityListVM.cities.first?.forecasts.first?.system  ?? .constant(CityForecastModel.init().system), label: Text("System")) {
                    Text("ºC").tag(0)
                    Text("ºF").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width:100)
                List {
                    ForEach(cityListVM.cities, id: \.id ) { city in
                        NavigationLink(value: city) {
                            CityCardView()
                                .environmentObject(city)
                        }
                       
                        .deleteDisabled(cityListVM.cities.count < 2)
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                }
              
                .navigationDestination(for: CityForecastModel.self) { cityforecast in
                    NewCityView(cityName: cityforecast.city.cityName)
                        .environmentObject(cityListVM)
                        .environmentObject(cityforecast)
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
            }
            Spacer()
                .navigationTitle("Weather")
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                .toolbar {
                    EditButton()
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
    
    func delete(at offsets: IndexSet) {
        cityListVM.cities.remove(atOffsets: offsets)
    }
    func move(from source: IndexSet, to destination: Int) {
        cityListVM.cities.move(fromOffsets: source, toOffset: destination)
    }
    
}

struct testMainPage_Previews: PreviewProvider {
    static var previews: some View {
        testMainPage(temp: CityForecastModel.init())
            .environmentObject(CityListViewModel())
    }
}
