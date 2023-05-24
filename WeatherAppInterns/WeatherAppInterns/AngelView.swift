//
//  AngelView.swift
//  WeatherAppInterns
//
//  Created by Leo Avalos on 16/05/23.
//

import SwiftUI
import CoreLocation
struct AngelView: View {
  @State  var forecast: MyWeatherList? = nil
    var body: some View {
       ZStack {
          VStack {
               ScrollView{
                  VStack {
                     //SummaryView(city: "Aguascalientes", actTemp: 28, minTemp: 12, maxTemp: 32)
                      ButtonSubtitle(text: "Mostly Sunny")
                          .shadow(color: .black ,radius: 15, x: 2, y: 2)
                    // HourlyView()
                      VStack(alignment: .leading, spacing: 10){
                         ButtonHeader(text: "10 - DAY FORECAST", systemImage: "calendar")
                         HeaderDivider()
                         
                        ForEach(1..<8) { row in
                          //DaysView(day: "Lunes", emoji: "☀️", minTemp: 12 , maxTemp: 31)
                           
                        }
                     }
                     .padding()
                     .background(Color("ButtonColor"))
                     .clipShape(RoundedRectangle(cornerRadius: 15))
                  }
               }
               .padding()
          }
           
          //NavBarView()
       }
       .background(Color("BackgroundColor"))
      
   }
  
  
   
}
  
//struct AngelView: View {
//  @State private var location: String = ""
//  @State  var forecast: MyWeatherList? = nil
//  let dataFormatter = DateFormatter()
//  init() {
//    dataFormatter.dateFormat = "EEEE, d, HH:mm"
//  }
//    var body: some View {
//       ZStack {
//          VStack {
//            ScrollView{
//              VStack {
////                //HStack {
////                  TextField("Enter Location", text: $location)
////                    .textFieldStyle(RoundedBorderTextFieldStyle())
////                  Button {
////                    getWeatherForecast(for: location)
////                  } label: {
////                    Image(systemName: "magnifyingglass.circle.fill")
////                      .font(.title3)
////                  }
////                }
//               // if let forecast = forecast {
//                  SummaryView(city: "Aguascalientes", actTemp: 28, minTemp: 12, maxTemp: 32)
//                  ButtonSubtitle(text: "Mostly Sunny")
//                  .shadow(color: .black ,radius: 15, x: 2, y: 2)
//                HourlyView(forecast: $forecast)
//                VStack(alignment: .leading, spacing: 10){
//                  ButtonHeader(text: "10 - DAY FORECAST", systemImage: "calendar")
//                  HeaderDivider()
//
//                  ForEach(1..<8) { row in
//                    DaysView(forecast: $forecast,day: "Lunes", emoji: "☀️", minTemp: 12 , maxTemp: 31)
//                  }
//
//                  }
//                }
//
//              }
//
//               }
//          .padding()
//          .background(Color("ButtonColor"))
//          .clipShape(RoundedRectangle(cornerRadius: 15))
//          //}
//          }
//       .padding()
//          //NavBarView()
//       }
//
//   }
//  func getWeatherForecast(for location: String){
//
//    let apiService = ApiService.shared
//
//    CLGeocoder().geocodeAddressString(location) { placemarks, error in
//      if let error = error {
//        print(error.localizedDescription)
//      }
//      if let lat = placemarks?.first?.location?.coordinate.latitude,
//         let lon = placemarks?.first?.location?.coordinate.longitude {
//        apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=23892ea6d93b8685d75fae33906a91ed&units=metric") { (result: Result<MyWeatherList,ApiService.APIError>) in
//          switch result {
//          case .success(let forecast):
//            self.forecast = forecast
////            for times in forecast.list   {
////              print(dataFormatter.string(from: times.dt))
////              print("Temperatura: ",times.main.temp)
////              print("Temperatura Maxima: ",times.main.tempMax)
////              print("Temperatura Minima: ",times.main.tempMin)
////              print("Presion: ",times.main.pressure)
////              print("Sensacion: ",times.main.fellsLike)
////              print("Speed",times.wind.speed)
////              print("Visibilidad: ",times.visibility)
////              print("Precipitqacion: ", times.pop)
////              print("Description: ", times.weather[0].description)
////              print("Id: ",times.weather[0].id)
////              print("Icon URL: ", times.weather[0].weatherIconURL)
//            //      }
//
//          case .failure(let apiError):
//            switch apiError {
//            case .error(let errorString):
//              print(errorString)
//            }
//          }
//        }
//        print("Lat: \(lat), Lon: \(lon)")
//      }
//    }
//}
    

  



struct SummaryView: View{
   var city: String
   var actTemp: String
   var minTemp: String
   var maxTemp: String
   
   var body: some View{
         VStack{
            TitleText(text: city)
            BigNumberText(text: "\(String(actTemp))º")
            HStack{
               ButtonSubtitle(text: "Low: \(String(minTemp))º")
                    .shadow(color: .black ,radius: 15, x: 2, y: 2)
               ButtonSubtitle(text: "High: \(String(maxTemp))º")
                    .shadow(color: .black ,radius: 15, x: 2, y: 2)
            }
      }

   }
}

struct HourlyView: View{
  var date: String
  var currentTemp: String
   var body: some View{
      VStack{
        ButtonDescription(text: "Condiciones ")
          HeaderDivider()
            ScrollView(.horizontal, showsIndicators: false){
                  HStack{
                    ForEach(1..<39) { element in
                        VStack(spacing: 10) {
                          NormalText(text: date)
                           NormalText(text: "☀️")
                          NormalText(text: currentTemp)
                         
                        }
                      
                  }
               }
         }
      }
      .padding()
      .background(Color("ButtonColor"))
      .clipShape(RoundedRectangle(cornerRadius: 15))
   }
}

struct DaysView: View{
   var day: String
   var emoji: String
   var minTemp: String
   var maxTemp: String
   
   var body: some View{
      VStack{
         Button {
         } label: {
            HStack{
               NormalText(text: day)
               Spacer()
               NormalText(text: emoji)
               Spacer()
               NormalText(text: String(minTemp))
               Spacer()
               NormalText(text: "------")
               Spacer()
               NormalText(text: String(maxTemp))
            }
         }
      }
      .background(Color("ButtonColor"))
    }
}

struct AngelView_Previews: PreviewProvider {
    static var previews: some View {
        AngelView()
            .background(Color("BackgroundColor"))
    }
}
