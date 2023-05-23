

import SwiftUI
import CoreLocation
import Combine
struct DemoView2: View {
  @StateObject private var forecastListVM = ForecastListViewModel()
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @State var tokens: Set<AnyCancellable> = []
  @State var coordinates: (lat: Double, lon: Double) = (0,0)
  let dataFormatter = DateFormatter()
  let dataFormatter2 = DateFormatter()
  init() {
    dataFormatter.dateFormat = "EEEE, d, HH:mm"
    dataFormatter2.dateFormat = "HH:mm"
  }
  var body: some View {
    
    ZStack {
      Color("BackgroundColor")
        .ignoresSafeArea()
        .opacity(50)
      
      VStack {
        Spacer()
        ScrollView (showsIndicators: false){
          
          VStack (spacing: 10){
            
            ZStack {
              VStack {
                ScrollView{
                  VStack {
                    HStack {
                      Button {
                        forecastListVM.getWeatherForecast()
                        forecastListVM.getCity()
                      } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                          .font(.title3)
                      }
                    }
                    List(forecastListVM.forecasts, id: \.day) { day in
                        VStack(alignment: .leading){
                          Text(day.day)
                            .fontWeight(.bold)
                          HStack(alignment: .top)
                          {
                            Image(systemName: "hourglass")
                              .font(.title)
                              .frame(width: 50, height: 50)
                              .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                            VStack(alignment: .leading)
                            {
                              Text(day.day)
                              Text(day.high)
                              Text(day.low)
                              Text(day.fellsLike)
                              Text(day.pressure)
                              Text(day.humidity)
                              Text(day.weatherDescription)
                              Text(day.clouds)
                              Text(day.windSpeed)
                              HStack {
                                Text(day.precipitation)
                                Text(day.windGust)
                                Text(day.windDeg)
                              }
                              


                            }
                            
                          }
                        }
                      }
                      .listStyle(PlainListStyle())
                    SummaryView(city: forecastListVM.city, actTemp: forecastListVM.forecasts.first?.low ?? "0", minTemp: "", maxTemp: "")
                      ButtonSubtitle(text: "")
                        .shadow(color: .black ,radius: 15, x: 2, y: 2)
                      //                      HourlyView(forecast: $forecast)
                      VStack(alignment: .leading, spacing: 10){
                        ButtonHeader(text: "10 - DAY FORECAST", systemImage: "calendar")
                        HeaderDivider()
                        
                        //                        ForEach(1..<8) { row in
                        //                          DaysView(forecast: $forecast, day: "Lunes", emoji: "☀️", minTemp: 12 , maxTemp: 31)
                        //
                        //                        }
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
       
              HStack (spacing: 15){
                Button{
                  print("UVIndex")
                } label: {
                  UVIndex(title: "11", subtitle: "Extreme", description: "Use sun protection until 17:00")
                    .modifier(ExtraInfoButton())
                }
                
                Button{
                  print("Sunset")
                } label: {
                  Sunset(title: "", description: "Sunrise:")
                    .modifier(ExtraInfoButton())
                }
                
              }
              HStack {
                // TRY CREATING A BUTTONVIEW RECEIVING CALLBACK
                Button{
                  print("Wind")
                } label: {
                  Wind(title: ")", description: "Descripcion")
                    .modifier(ExtraInfoButton())
                }
                
                Button{
                  print("Precipitation")
                } label: {
                  Precipitation(title: "", subtitle: "in last 24h", description: "None expected in next 10 days.")
                    .modifier(ExtraInfoButton())
                }
                
              }
              HStack {
                Button{
                  print("FeelsLike")
                } label: {
                  FeelsLike(title: "", description: "Wind is making it feel cooler")
                    .modifier(ExtraInfoButton())
                }
                
                Button{
                  print("Humidity")
                } label: {
                  Humidity(title: "%", description: "The dew point is 4º right now.")
                    .modifier(ExtraInfoButton())
                }
                
              }
              HStack {
                Button{
                  print("Visibility")
                } label: {
                  Visibility(title: "km", description: "It's perfectly clear right now")
                    .modifier(ExtraInfoButton())
                }
                
                Button{
                  print("Pressure")
                } label: {
                  Pressure(title: "", description: "Light Pressure")
                    .modifier(ExtraInfoButton())
                }
                
              }
            
          }
        }
        Spacer()
        NavBarView()
      }
      
    }
  }

  func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
  }
}



struct DemoView2_Previews: PreviewProvider {
  static var previews: some View {
    DemoView2()
      .background(Color("BackgroundColor"))
  }
}


