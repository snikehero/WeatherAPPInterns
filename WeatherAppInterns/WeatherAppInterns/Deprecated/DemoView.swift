////
////  DemoView.swift
////  WeatherAppInterns
////
////  Created by Leo Avalos on 16/05/23.
////
//
//import SwiftUI
//import CoreLocation
//struct DemoView: View {
//  @State private var location: String = ""
//  @State  var forecast: MyWeatherList? = nil
//  let dataFormatter = DateFormatter()
//  let dataFormatter2 = DateFormatter()
//  init() {
//    dataFormatter.dateFormat = "EEEE, d, HH:mm"
//    dataFormatter2.dateFormat = "HH:mm"
//  }
//  var body: some View {
//    
//    ZStack {
//      Color("BackgroundColor")
//        .ignoresSafeArea()
//        .opacity(50)
//      
//      VStack {
//        Spacer()
//        ScrollView (showsIndicators: false){
//          
//          VStack (spacing: 10){
//            
//            ZStack {
//              VStack {
//                ScrollView{
//                  VStack {
//                    HStack {
//                      TextField("Enter Location", text: $location)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                      Button {
//                        getWeatherForecast(for: location)
//                      } label: {
//                        Image(systemName: "magnifyingglass.circle.fill")
//                          .font(.title3)
//                      }
//                    }
//                    if let forecast = forecast {
//                     // SummaryView(city: forecast.city.name, actTemp: forecast.list[0].main.temp, minTemp: forecast.list[0].main.tempMin, maxTemp: forecast.list[0].main.tempMax)
//                      ButtonSubtitle(text: forecast.list[0].weather[0].description)
//                        .shadow(color: .black ,radius: 15, x: 2, y: 2)
//                      //HourlyView()
//                      VStack(alignment: .leading, spacing: 10){
//                        ButtonHeader(text: "10 - DAY FORECAST", systemImage: "calendar")
//                        HeaderDivider()
//                        
//                        ForEach(1..<8) { row in
//                          //DaysView(day: "Lunes", emoji: "☀️", minTemp: 12 , maxTemp: 31)
//                          
//                        }
//                      }
//                      .padding()
//                      .background(Color("ButtonColor"))
//                      .clipShape(RoundedRectangle(cornerRadius: 15))
//                    }
//                    
//                  }
//                  
//                }
//                .padding()
//              }
//              
//              //NavBarView()
//            }
//            if (forecast != nil) {
//              HStack (spacing: 15){
//                Button{
//                  print("UVIndex")
//                } label: {
//                  UVIndex(title: "11", subtitle: "Extreme", description: "Use sun protection until 17:00")
//                    .modifier(ExtraInfoButton())
//                }
//                
//                Button{
//                  print("Sunset")
//                } label: {
//                  Sunset(title: "\(dataFormatter2.string(from: NSDate(timeIntervalSince1970: (forecast?.city.sunset)!) as Date))", description: "Sunrise: \(dataFormatter2.string(from: NSDate(timeIntervalSince1970: (forecast?.city.sunrise)!) as Date))")
//                    .modifier(ExtraInfoButton())
//                }
//                
//              }
//              HStack {
//                // TRY CREATING A BUTTONVIEW RECEIVING CALLBACK
//                Button{
//                  print("Wind")
//                } label: {
//                  Wind(title: "\(forecast?.list[0].wind.speed ?? 0)", description: "Descripcion", degrees: "90")
//                    .modifier(ExtraInfoButton())
//                }
//                
//                Button{
//                  print("Precipitation")
//                } label: {
//                  Precipitation(title: "\(forecast?.list[0].pop ?? 0)", subtitle: "in last 24h", description: "None expected in next 10 days.")
//                    .modifier(ExtraInfoButton())
//                }
//                
//              }
//              HStack {
//                Button{
//                  print("FeelsLike")
//                } label: {
//                  FeelsLike(title: "\(forecast?.list[0].main.fellsLike ?? 0)", description: "Wind is making it feel cooler")
//                    .modifier(ExtraInfoButton())
//                }
//                
//                Button{
//                  print("Humidity")
//                } label: {
//                  Humidity(title: "\(forecast?.list[0].main.humidity ?? 0)%", description: "The dew point is 4º right now.")
//                    .modifier(ExtraInfoButton())
//                }
//                
//              }
//              HStack {
//                Button{
//                  print("Visibility")
//                } label: {
//                  Visibility(title: "\((forecast?.list[0].visibility)! / 1000 )km", description: "It's perfectly clear right now")
//                    .modifier(ExtraInfoButton())
//                }
//                
//                Button{
//                  print("Pressure")
//                } label: {
//                  Pressure(title: "\(forecast?.list[0].main.pressure ?? 0) ", description: "Light Pressure")
//                    .modifier(ExtraInfoButton())
//                }
//                
//              }
//            }
//          }
//        }
//        Spacer()
//        NavBarView()
//      }
//      
//    }
//  }
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
//            //            for times in forecast.list   {
//            //              print(dataFormatter.string(from: times.dt))
//            //              print("Temperatura: ",times.main.temp)
//            //              print("Temperatura Maxima: ",times.main.tempMax)
//            //              print("Temperatura Minima: ",times.main.tempMin)
//            //              print("Presion: ",times.main.pressure)
//            //              print("Sensacion: ",times.main.fellsLike)
//            //              print("Speed",times.wind.speed)
//            //              print("Visibilidad: ",times.visibility)
//            //              print("Precipitqacion: ", times.pop)
//            //              print("Description: ", times.weather[0].description)
//            //              print("Id: ",times.weather[0].id)
//            //              print("Icon URL: ", times.weather[0].weatherIconURL)
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
//    
//    
//    
//  }
//  func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
//      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
//  }
//}
//
//
//
//struct DemoView_Previews: PreviewProvider {
//  static var previews: some View {
//    DemoView()
//      .background(Color("BackgroundColor"))
//  }
//}
//
