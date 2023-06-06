//
//  CityView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 30/05/23.
//

import SwiftUI

struct CityView: View {
//  @Binding var arraycitis: [ForecastViewModel]
//  @Binding var cityName: CityViewModel
  @Binding var cities: [CityForecastModel]
  var citiesList: CityListViewModel
  //Cambiar para recibir CityForecastModel
  //4.-
  var body: some View {
   
//    List {
//
//        VStack() {
//          Text(cityName.cityName)
//
//      }
//      ForEach($arraycitis, id: \.id) { element in
//        VStack(spacing: 10) {
//
//          VStack(alignment: .leading) {
//            Text(element.wrappedValue.high)
//              .font(.system(size: 30, weight: .medium, design: .rounded))
//              .padding(.vertical, 5)
//
//          }
//        }
//      }
//    }
    
    //New
//    VStack {
//      Text("Cities")
//      List {
//        ForEach($cities, id: \.id) { element in
//          Text(element.city.wrappedValue.cityName)
//        }
//      }
//    }
    
    //New2
        ForEach(citiesList.cities, id: \.id) { element in
          VStack{
              HStack{
                  TitleTextCities(text: element.city.cityName )
                  Spacer()
                  BigTempWigdet(text: "\(element.forecasts.first?.current ?? "0") º" )
              }
              .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
              HStack{
                  NormalText(text:"Summary")
                  Spacer()
                  NormalText(text: "H: \(element.forecasts.first?.high ?? "0") º")
                  NormalText(text: "L: \(element.forecasts.first?.low ?? "0") º")
              }
              .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))


          }
          .background(Color("BackgroundColor"))
          .ignoresSafeArea()
          .clipShape(RoundedRectangle(cornerRadius: 15))
          .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
      Spacer()
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
//      CityView(arraycitis: .constant([ForecastViewModel.mock]), cityName: .constant(.mock))      //Text("Preview")
      CityView(cities: .constant([CityForecastModel.init()]),citiesList:  CityListViewModel.init())
      
    }
}
