

import SwiftUI
import CoreLocation
import Combine
struct DemoView2: View {
  @StateObject var forecastListVM = ForecastListViewModel()
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @StateObject private var dailyForecastListVM = DailyForecastListViewmodel()
  @State var tokens: Set<AnyCancellable> = []
  @State var coordinates: (lat: Double, lon: Double) = (0,0)
  @State var isPrecipitationShowing = false
  @State var isVisibilityShowing = false
  @State var isWindShowing = false
  @State var isUVIndexShowing = false
  @State var isFeelsLikeShowing = false
  @State var isHumidityShowing = false
  @State var isPressureShowing = false
  @State var airPollutionListVM = AirPollutionListViewModel()
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
                        airPollutionListVM.getAirPollution()
                        
                      } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                          .font(.title3)
                      }
                    }
                    SummaryView(city: forecastListVM.city.cityName, actTemp: forecastListVM.forecasts.first?.current ?? "0", minTemp: forecastListVM.forecasts.first? .low ?? "0", maxTemp: forecastListVM.forecasts.first?.high ?? "0")
                    ButtonSubtitle(text: forecastListVM.forecasts.first?.overview ?? "0")
                      .shadow(color: .black ,radius: 15, x: 2, y: 2)
                    //HourlyView(date: "", currentTemp: "")
                    HourlyView2(forecasts: $forecastListVM.forecasts)
                    AirPollutionView(title: "AirPollution", subtitle: airPollutionListVM.airPollutions.first?.index ?? "0", description: airPollutionListVM.airPollutions.first?.airPollutionDescription ?? "N/A")
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
                isUVIndexShowing = true
              } label: {
                UVIndex(title: dailyForecastListVM.dailyForecasts.first?.uvi ?? "0", subtitle: dailyForecastListVM.dailyForecasts.first?.subtitle ?? "normal", description: dailyForecastListVM.dailyForecasts.first?.description ?? "use")
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
                isWindShowing = true
              } label: {
                Wind(title: "\(forecastListVM.forecasts.first?.windSpeed ?? "0")", description: "Descripcion")
                  .modifier(ExtraInfoButton())
              }
              
              
              Button{
                print("Precipitation")
                isPrecipitationShowing = true
              } label: {
                Precipitation(title: "\(forecastListVM.forecasts.first?.precipitation ?? "0")", subtitle: "in last 24h", description: forecastListVM.forecasts.first?.popDescription ?? "normal")
                  .modifier(ExtraInfoButton())
              }
              
            }
            HStack {
              Button{
                print("FeelsLike")
                isFeelsLikeShowing = true
              } label: {
                FeelsLike(title: "\(forecastListVM.forecasts.first?.fellsLike ?? "0")", description: forecastListVM.forecasts.first?.feelsLikeDescription ?? "Normal")
                  .modifier(ExtraInfoButton())
              }
              
              Button{
                print("Humidity")
                isHumidityShowing = true
              } label: {
                Humidity(title: "\(forecastListVM.forecasts.first?.humidity ?? "0")%", description: "The dew point is 4º right now.")
                  .modifier(ExtraInfoButton())
              }
              
            }
            HStack {
              Button{
                print("Visibility")
                isVisibilityShowing = true
              } label: {
                Visibility(title: "\(forecastListVM.forecasts.first?.visibility ?? "0")km", description: "\(forecastListVM.forecasts.first?.visibilityDescription ?? "N/A")")
                  .modifier(ExtraInfoButton())
              }
              
              Button{
                print("Pressure")
                isPressureShowing = true
              } label: {
                Pressure(title: "\(forecastListVM.forecasts.first?.pressure ?? "0")", description: forecastListVM.forecasts.first?.pressureDescription ?? "normal")
                  .modifier(ExtraInfoButton())
              }
              
            }
            
          }
          .sheet(isPresented: $isPrecipitationShowing) {
            PrecipitationExtraInfo(isPrecipitationShowing: $isPrecipitationShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "There has been \(forecastListVM.forecasts.first?.precipitation ?? "0") % of precipitation in the last 24 hours. Today's total precipitation will be \(forecastListVM.forecasts.first?.precipitation ?? "0")", precipitation: forecastListVM.forecasts.first?.precipitation ?? "0")
          }
          
          .sheet(isPresented: $isVisibilityShowing) {
            VisibilityExtraInfo(isVisibilityShowing: $isVisibilityShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "Today, the visibility will be \(forecastListVM.forecasts.first?.visibilityDescription ?? "0"), at \(forecastListVM.forecasts.first?.visibility ?? "0")km to \(forecastListVM.forecasts.first?.visibility ?? "0")km", visibility: "\(forecastListVM.forecasts.first?.visibility ?? "0")km")
          }.sheet(isPresented: $isWindShowing) {
            WindExtraInfo(isWindShowing: $isWindShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "Wind is currently \(forecastListVM.forecasts.first?.windSpeed ?? "0") km/h from the west-northwest. Today, wind speeds are \(forecastListVM.forecasts.first?.windSpeed ?? "0") km/h to \(forecastListVM.forecasts.last?.windSpeed ?? "0") km/h, with gusts up to \(forecastListVM.forecasts.first?.windGust ?? "0") km/h.", wind: "\(forecastListVM.forecasts.first?.windSpeed ?? "0") km/h", gusts: "\(forecastListVM.forecasts.first?.windGust ?? "0") km/h")
          }.sheet(isPresented: $isFeelsLikeShowing) {
            FeelsLikeExtraInfo(isFeelsLikeShowing: $isFeelsLikeShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "The temperature currently feels like \(forecastListVM.forecasts.first?.fellsLike ?? "0")º but it is actually \(forecastListVM.forecasts.first?.current ?? "0")º. \(forecastListVM.forecasts.first?.feelsLikeDescription ?? "0"). Today's temperature range felt like 16º to 31º", feelsLike: "\(forecastListVM.forecasts.first?.fellsLike ?? "0")", actual: "\(forecastListVM.forecasts.first?.current ?? "0")")
          }.sheet(isPresented: $isHumidityShowing) {
            HumidityExtraInfo(isHumidityShowing: $isHumidityShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "Today, the average humidity is \(forecastListVM.forecasts.first?.humidity ?? "0")%- The dew point is 1º to 6º", humidity: "\(forecastListVM.forecasts.first?.humidity ?? "0")", dewPoint: "2")
          }.sheet(isPresented: $isPressureShowing) {
            PressureExtraInfo(isPressureShowing: $isPressureShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "Pressure is currently \(forecastListVM.forecasts.first?.pressure ?? "0") hPa and falling. Today, the average pressure will be 1,010 hPa, and the lowest pressure will be 1,006 hPa.", pressure: "\(forecastListVM.forecasts.first?.pressure ?? "0")")
          }.sheet(isPresented: $isUVIndexShowing) {
            UvIndexExtraInfo(isUVIndexShowing: $isUVIndexShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "\(dailyForecastListVM.dailyForecasts.first?.description ?? "normal"). Levels of \(dailyForecastListVM.dailyForecasts.first?.subtitle ?? "normal") or higher are reached from 9:00 to 18:00.", uvIndex: "\(dailyForecastListVM.dailyForecasts.first?.uvi ?? "0")", uvIndexDescription:"\(dailyForecastListVM.dailyForecasts.first?.subtitle ?? "0")" )
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
  @Binding var forecasts: [ForecastViewModel]
  var testing = false
  var body: some View{
    VStack{
      ButtonDescription(text: "Condiciones ")
      HeaderDivider()
      ScrollView(.horizontal, showsIndicators: false){
        HStack{
          
          ForEach($forecasts, id: \.id) { element in
            VStack(spacing: 10) {
              NormalText(text: element.wrappedValue.day)
              NormalText(text: "☀️")
              NormalText(text: element.wrappedValue.high)
            }
          }
        }
        .onAppear() {
          if(testing == false)
          {
            //forecasts.getWeatherForecast()
            
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



