//
//  TestView.swift
//  WeatherAppInterns
//
//  Created by Leo Avalos on 31/05/23.
//

import SwiftUI
import CoreLocation
import Combine

struct TestView: View {
  //Seria WeatherCityView ya que vive todo aqui...
  @State private var isSheetPresented = false
  @StateObject var forecastListVM = CityForecastModel()
  @StateObject var cityListVM = CityListViewModel()
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @State var searchText = ""
  @State var tokens: Set<AnyCancellable> = []
  //@State var arrayCitis = [ForecastViewModel]()
  //@State var arrayNames = [CityViewModel]()
  var body: some View {
    VStack {
      NavigationStack {
        Text("Searching for \(searchText)")
          .navigationTitle("Weather")
        NavigationLink {
          EmptyView()
        } label: {
          CityView(arraycitis: $forecastListVM.forecasts,cityName: $forecastListVM.city)
          //Pasar CityForecastModel
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
              forecastListVM.getCityByName(cityName: searchText)
              //Anadir el CityListViewModel
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
  
  func observeCoordinatesUpdates()
  {
    deviceLocationService.coordinatesPublisher
      .receive(on: DispatchQueue.main)
      .sink {completion in
        if case .failure (let error) = completion {
          print(error)
        }
      } receiveValue: { coordinates in
        forecastListVM.getCityByName(cityName: searchText)
        //         forecastListVM.getWeatherForecast()
        //         forecastListVM.getCity()
        //         forecastListVM.location = "location"
      }
      .store(in: &tokens)
  }
  func observeLocationAccessDenied() {
    deviceLocationService.deniedLocationAccessPublisher
      .receive(on: DispatchQueue.main)
      .sink {
        print("Show some kind of alert to the user")
        forecastListVM.getCityByName(cityName: "Cupertino")
        //         forecastListVM.getWeatherForecast()
        //         forecastListVM.getCity()
        //         forecastListVM.location = "location"
      }
      .store(in: &tokens)
  }
  
  
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    TestView()
  }
}
