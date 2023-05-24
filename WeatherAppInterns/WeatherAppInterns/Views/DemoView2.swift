

import SwiftUI
import CoreLocation
import Combine
struct DemoView2: View {
  @StateObject var forecastListVM = ForecastListViewModel()
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @StateObject private var dailyForecastListVM = DailyForecastListViewmodel()
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
                        dailyForecastListVM.getDailyWeatherForecast()
                        forecastListVM.location = "location"
                        dailyForecastListVM.location = "location"
                      } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                          .font(.title3)
                      }
                    }
                    SummaryView(city: forecastListVM.city.cityName, actTemp: forecastListVM.forecasts.first?.current ?? "0", minTemp: forecastListVM.forecasts.first? .low ?? "0", maxTemp: forecastListVM.forecasts.first?.high ?? "0")
                    ButtonSubtitle(text: forecastListVM.forecasts.first?.overview ?? "0")
                      .shadow(color: .black ,radius: 15, x: 2, y: 2)
                    //HourlyView(date: "", currentTemp: "")
                    HourlyView2()
                    AirPollutionView(airPollutionIndexString: "10", airPollutionIndexNumber: 5)
                    
                    VStack(alignment: .leading, spacing: 10){
                      ButtonHeader(text: "10 - DAY FORECAST", systemImage: "calendar")
                      HeaderDivider()
                      if let dailyForecast = $dailyForecastListVM.dailyForecasts.first {
                        ForEach(0..<7) { row in
                          DaysView(day: dailyForecastListVM.dailyForecasts[row].day ?? "0" , emoji: "☀️", minTemp: dailyForecastListVM.dailyForecasts[row].minTemp ?? "0" , maxTemp: dailyForecastListVM.dailyForecasts[row].maxTemp ?? "0")
                          
                        }
                        
                      }
                   
                        //DaysView2()
                        
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
                  Sunset(title: forecastListVM.city.sunset, description: "Sunrise: \(forecastListVM.city.sunrise)")
                    .modifier(ExtraInfoButton())
                }
                
              }
              HStack {
                // TRY CREATING A BUTTONVIEW RECEIVING CALLBACK
                Button{
                  print("Wind")
                } label: {
                  Wind(title: "\(forecastListVM.forecasts.first?.windSpeed ?? "0")", description: "Descripcion")
                    .modifier(ExtraInfoButton())
                }
                
                Button{
                  print("Precipitation")
                } label: {
                  Precipitation(title: "\(forecastListVM.forecasts.first?.precipitation ?? "0")", subtitle: "in last 24h", description: "None expected in next 10 days.")
                    .modifier(ExtraInfoButton())
                }
                
              }
              HStack {
                Button{
                  print("FeelsLike")
                } label: {
                  FeelsLike(title: "\(forecastListVM.forecasts.first?.fellsLike ?? "0")", description: "Wind is making it feel cooler")
                    .modifier(ExtraInfoButton())
                }
                
                Button{
                  print("Humidity")
                } label: {
                  Humidity(title: "\(forecastListVM.forecasts.first?.humidity ?? "0")%", description: "The dew point is 4º right now.")
                    .modifier(ExtraInfoButton())
                }
                
              }
              HStack {
                Button{
                  print("Visibility")
                } label: {
                  Visibility(title: "\(forecastListVM.forecasts.first?.visibility ?? "0")km", description: "It's perfectly clear right now")
                    .modifier(ExtraInfoButton())
                }
                
                Button{
                  print("Pressure")
                } label: {
                  Pressure(title: "\(forecastListVM.forecasts.first?.pressure ?? "0")", description: "Light Pressure")
                    .modifier(ExtraInfoButton())
                }
                
              }
              
            }
          }
          Spacer()
          NavBarView()
        }
        .onAppear()
        {
          
          observeCoordinatesUpdates()
          observeLocationAccessDenied()
          deviceLocationService.requestLocationUpdates()
          
        }
        
      }
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
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
          self.coordinates = (coordinates.latitude, coordinates.longitude)
          forecastListVM.coordinates = (coordinates.latitude, coordinates.longitude)
        }
        .store(in: &tokens)
    }
    
    func observeLocationAccessDenied() {
      deviceLocationService.deniedLocationAccessPublisher
        .receive(on: DispatchQueue.main)
        .sink {
          print("Show some kind of alert to the user")
        }
        .store(in: &tokens)
    }
  }

struct HourlyView2: View{
  @StateObject var forecastListVM = ForecastListViewModel()
  var testing = true
   var body: some View{
      VStack{
        ButtonDescription(text: "Condiciones ")
          HeaderDivider()
            ScrollView(.horizontal, showsIndicators: false){
                  HStack{
                    
                    if let forecast = $forecastListVM.forecasts.first
                    {
                      
                      ForEach(1..<39) { element in
                        VStack(spacing: 10) {
                          NormalText(text: forecastListVM.forecasts[element].day ?? "")
                          NormalText(text: "☀️")
                          NormalText(text: forecastListVM.forecasts[element].high
                          ?? "")
                          
                        }
                      }
                      
                    }
               }
                  .onAppear() {
                    if(testing == false)
                    {
                      forecastListVM.getWeatherForecast()
                      
                    }
                  }
                
         }
      }
      .padding()
      .background(Color("ButtonColor"))
      .clipShape(RoundedRectangle(cornerRadius: 15))
   }
}
struct DaysView2: View{
    var day: Date
    var minTemp: String
    var maxTemp: String
    var body: some View{
      VStack{
        Button {
        } label: {
          HStack{
            NormalText(text: "")
            Spacer()
            NormalText(text: minTemp)
            Spacer()
            NormalText(text: maxTemp)
            Spacer()
            NormalText(text: "------")
            Spacer()
            NormalText(text: "asdadsa")
          }
        }
      }
      .background(Color("ButtonColor"))
    }
  }
  
  struct DemoView2_Previews: PreviewProvider {
    static var previews: some View {
      DemoView2()
        .background(Color("BackgroundColor"))
      //DaysView2()
    }
  }
  
  
  
