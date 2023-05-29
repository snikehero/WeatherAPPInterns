

import SwiftUI
import CoreLocation
import Combine

enum showingSheets2{
    case precipitation, visibility, wind, uvIndex, feelsLike, humidity, pressure
}

struct DemoView3: View {
  @StateObject var forecastListVM = ForecastListViewModel()
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @StateObject private var dailyForecastListVM = DailyForecastListViewmodel()
  @State var tokens: Set<AnyCancellable> = []
  @State var coordinates: (lat: Double, lon: Double) = (0,0)
  @State var selectedSheet: showingSheets2 = .precipitation
  @State var isShowing = false
  @State var airPollutionListVM = AirPollutionListViewModel()
  let dataFormatter = DateFormatter()
  let dataFormatter2 = DateFormatter()
  init() {
    dataFormatter.dateFormat = "EEEE, d, HH:mm"
    dataFormatter2.dateFormat = "HH:mm"
  }
  var body: some View {
    NavigationStack {
      ZStack {
        //BackgroundView()
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
                      SummaryView3(forecasts: $forecastListVM.forecasts,cityName: forecastListVM.city.cityName)
                      ButtonSubtitle(text: forecastListVM.forecasts.first?.overview ?? "overview")
                        .shadow(color: .black ,radius: 15, x: 2, y: 2)
                      HourlyView3(forecasts: $forecastListVM.forecasts)
                      AirPollutionView2(airPollution: $airPollutionListVM.airPollutions)
                      VStack(alignment: .leading, spacing: 10){
                        ButtonHeader(text: "8 - DAY FORECAST", systemImage: "calendar")
                        HeaderDivider()
                        DaysView3(dailyForecasts: $dailyForecastListVM.dailyForecasts)
                      }
                      .padding()
                      .background(.ultraThinMaterial)
                      .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                  }
                  .padding()
                }
              }
              HStack (spacing: 15){
                Button{
                  print("UVIndex")
                  selectedSheet = .uvIndex
                  isShowing.toggle()
                } label: {
                  UVIndex2(dailyForecasts: $dailyForecastListVM.dailyForecasts)
                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Sunset")
                  
                } label: {
                  Sunset2(title: forecastListVM.city.sunset, description: "Sunrise: \(forecastListVM.city.sunrise)")
                    .modifier(ExtraInfoButton())
                }
              }
              HStack {
                Button{
                  print("Wind")
                  selectedSheet = .wind
                  isShowing.toggle()
                } label: {
                  Wind2(forecasts: $forecastListVM.forecasts)
                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Precipitation")
                  selectedSheet = .precipitation
                  isShowing.toggle()
                } label: {
                  Precipitation2(forecasts: $forecastListVM.forecasts)
                    .modifier(ExtraInfoButton())
                }
              }
              HStack {
                Button{
                  print("FeelsLike")
                  selectedSheet = .feelsLike
                  isShowing.toggle()
                } label: {
                  FeelsLike2(forecasts: $forecastListVM.forecasts)
                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Humidity")
                  selectedSheet = .humidity
                  isShowing.toggle()
                } label: {
                  Humidity2(forecasts: $forecastListVM.forecasts)
                    .modifier(ExtraInfoButton())
                }
              }
              HStack {
                Button{
                  print("Visibility")
                  selectedSheet = .visibility
                  isShowing.toggle()
                } label: {
                  Visibility2(forecasts: $forecastListVM.forecasts)
                    .modifier(ExtraInfoButton())
                }
                Button{
                  print("Pressure")
                  selectedSheet = .pressure
                  isShowing.toggle()
                } label: {
                  Pressure2(forecasts: $forecastListVM.forecasts)
                    .modifier(ExtraInfoButton())
                }
              }
            }
            .sheet(isPresented: $isShowing){
              switch selectedSheet {
              case .precipitation:
                PrecipitationExtraInfo(isShowing: $isShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "There has been \(forecastListVM.forecasts.first?.precipitation ?? "0") % of precipitation in the last 24 hours. Today's total precipitation will be \(forecastListVM.forecasts.first?.precipitation ?? "0")", precipitation: forecastListVM.forecasts.first?.precipitation ?? "0")
              case .visibility:
                VisibilityExtraInfo(isShowing: $isShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "Today, the visibility will be \(forecastListVM.forecasts.first?.visibilityDescription ?? "0"), at \(forecastListVM.forecasts.first?.visibility ?? "0")km to \(forecastListVM.forecasts.first?.visibility ?? "0")km", visibility: "\(forecastListVM.forecasts.first?.visibility ?? "0")km")
              case .wind:
                WindExtraInfo(isShowing: $isShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "Wind is currently \(forecastListVM.forecasts.first?.windSpeed ?? "0") km/h from the west-northwest. Today, wind speeds are \(forecastListVM.forecasts.first?.windSpeed ?? "0") km/h to \(forecastListVM.forecasts.last?.windSpeed ?? "0") km/h, with gusts up to \(forecastListVM.forecasts.first?.windGust ?? "0") km/h.", wind: "\(forecastListVM.forecasts.first?.windSpeed ?? "0") km/h", gusts: "\(forecastListVM.forecasts.first?.windGust ?? "0") km/h")
              case .uvIndex:
                UvIndexExtraInfo(isShowing: $isShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "\(dailyForecastListVM.dailyForecasts.first?.description ?? "normal"). Levels of \(dailyForecastListVM.dailyForecasts.first?.subtitle ?? "normal") or higher are reached from 9:00 to 18:00.", uvIndex: "\(dailyForecastListVM.dailyForecasts.first?.uvi ?? "0")", uvIndexDescription:"\(dailyForecastListVM.dailyForecasts.first?.subtitle ?? "0")" )
              case .feelsLike:
                FeelsLikeExtraInfo(isShowing: $isShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "The temperature currently feels like \(forecastListVM.forecasts.first?.fellsLike ?? "0")º but it is actually \(forecastListVM.forecasts.first?.current ?? "0")º. \(forecastListVM.forecasts.first?.feelsLikeDescription ?? "0"). Today's temperature range felt like 16º to 31º", feelsLike: "\(forecastListVM.forecasts.first?.fellsLike ?? "0")", actual: "\(forecastListVM.forecasts.first?.current ?? "0")")
                
              case .humidity:
                HumidityExtraInfo(isShowing: $isShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "Today, the average humidity is \(forecastListVM.forecasts.first?.humidity ?? "0")%- The dew point is 1º to 6º", humidity: "\(forecastListVM.forecasts.first?.humidity ?? "0")", dewPoint: "2")
                
              case .pressure:
                PressureExtraInfo(isShowing: $isShowing, currentDay: forecastListVM.forecasts.first?.exactDayName ?? "D", numberDay: 26, date: Date(), dailySummary: "Pressure is currently \(forecastListVM.forecasts.first?.pressure ?? "0") hPa and falling. Today, the average pressure will be 1,010 hPa, and the lowest pressure will be 1,006 hPa.", pressure: "\(forecastListVM.forecasts.first?.pressure ?? "0")")
              }
              
              
            }
            Spacer()
          }
          .onAppear(){
            observeCoordinatesUpdates()
            observeLocationAccessDenied()
            deviceLocationService.requestLocationUpdates()
          }
          
        }
        .toolbar{
          ToolbarItemGroup(placement: .bottomBar){
            NavBarView()
          }
        }
      }
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
struct DemoView3_Previews: PreviewProvider {
  static var previews: some View {
    DemoView2()
      .background(Color("BackgroundColor"))
    //DaysView2()
  }
}
struct HourlyView3: View{
  @Binding var forecasts: [ForecastViewModel]
  var testing = false
  var body: some View{
    VStack{
      ButtonDescription(text: "Cloudy conditions expected ")
      HeaderDivider()
      ScrollView(.horizontal, showsIndicators: false){
        HStack{
          
          ForEach($forecasts, id: \.id) { element in
            VStack(spacing: 10) {
              NormalText(text: element.wrappedValue.hourDay)
              NormalText(text: "☀️")
              NormalText(text: "\(element.wrappedValue.high)º")
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
    .background(.ultraThinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 15))
  }
}
struct SummaryView3: View{
  @Binding var forecasts: [ForecastViewModel]
  var cityName: String
   var body: some View{
         VStack{
            TitleText(text: cityName)
           BigNumberText(text: "\(forecasts.first?.current ?? "0")º")
            HStack{
              ButtonSubtitle(text: "Low: \(forecasts.first?.low ?? "0")º")
                    .shadow(color: .black ,radius: 15, x: 2, y: 2)
              ButtonSubtitle(text: "High: \(forecasts.first?.high ?? "0")º")
                    .shadow(color: .black ,radius: 15, x: 2, y: 2)
            }
      }
     

   }
}
struct DaysView3: View{
  @Binding var dailyForecasts: [DailyForecastViewModel]
   var body: some View{
     ForEach($dailyForecasts, id: \.id) { element in
       VStack{
         Button {
         } label: {
           HStack{
             //day
             NormalText(text: element.wrappedValue.day)
             Spacer()
             //emoji
             NormalText(text: "☀️")
             Spacer()
             //minTemp
             NormalText(text: element.wrappedValue.minTemp)
             Spacer()
             NormalText(text: "------")
             Spacer()
             //maxtemp
             NormalText(text: element.wrappedValue.maxTemp)
           }
         }
       }
     }
    }
}
struct AirPollutionView2: View {
  @Binding var airPollution: [AirPollutionViewModel]
    var body: some View {
        VStack(alignment: .leading) {
            ButtonHeader(text: "Air Quality".uppercased(), systemImage: "aqi.medium")
            HeaderDivider()
          ButtonSubtitle(text: airPollution.first?.index ?? "0")
          ButtonDescription(text: airPollution.first?.airPollutionDescription ?? "0")
            //agregar la grafica y modificar su valor dependiendo de airpollution.indexRectangle()
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [Color.red, Color.blue]),
                    startPoint: .init(x: 0.5, y: 0),
                    endPoint: .init(x: 0.5, y: 0.6)
                ))
                .frame(width: 300, height: 10)
                .frame(width: 300, height: 30)
            
        }
        .frame(maxWidth: 350)
        .multilineTextAlignment(.leading)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}
//Buttons View
struct UVIndex2: View {
  @Binding var dailyForecasts: [DailyForecastViewModel]
    var body: some View {
        
        VStack(alignment: .leading) {
            ButtonHeader(text: "UV INDEX", systemImage: "sun.max.fill")
            
            HeaderDivider()
          ButtonTitle(text: dailyForecasts.first?.uvi ?? "UVI")
          ButtonSubtitle(text: dailyForecasts.first?.subtitle ?? "Subitle")
          ButtonDescription(text: dailyForecasts.first?.description ?? "Description")
            Spacer()
        }
        .padding()
    }
}

struct Sunset2: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ButtonHeader(text: "SUNSET", systemImage: "sunset.fill")
                Spacer()
            }
            HeaderDivider()
            ButtonTitle(text: title)
            ButtonDescription(text: description)
            Spacer()
        }.padding()
    }
}

struct Wind2: View {
  @Binding var forecasts: [ForecastViewModel]
    var body: some View {
        
        ZStack {
            Image("Compass")
                .resizable()
                .frame(maxWidth: 130, maxHeight: 130)
                .padding(.top, 30)
            Image("Arrow")
            .rotationEffect(.degrees(Double(forecasts.first?.windDeg ?? "0") ?? 0))
                .padding(.top)
            Text("34")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)

            VStack {
                HStack {
                    ButtonHeader(text: "WIND", systemImage: "wind")
                    Spacer()
                }
                HeaderDivider()
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        
    }
}

struct Precipitation2: View {
  @Binding var forecasts: [ForecastViewModel]
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "PRECIPITATION", systemImage: "drop.fill")
                Spacer()
            }
            HeaderDivider()
          ButtonTitle(text: forecasts.first?.precipitation ?? "Precipitation")
          ButtonSubtitle(text: "in last 24 h")
            Spacer()
          ButtonDescription(text: forecasts.first?.popDescription ?? "POP description")
            
            Spacer()
        }.padding()
    }
}

struct FeelsLike2: View {
  @Binding var forecasts: [ForecastViewModel]

      var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "FEELS LIKE", systemImage: "thermometer.medium")
                Spacer()
            }
            HeaderDivider()
          ButtonTitle(text: forecasts.first?.fellsLike ?? "feelslike")
            Spacer()
          ButtonDescription(text: forecasts.first?.feelsLikeDescription ?? "feelslikedescription")
            
            Spacer()
        }.padding()
    }
}

struct Humidity2: View {
  @Binding var forecasts: [ForecastViewModel]
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "HUMIDITY", systemImage: "humidity")
                Spacer()
            }
            HeaderDivider()
            ButtonTitle(text: forecasts.first?.humidity ?? "Humidity")
            Spacer()
            
            ButtonDescription(text: "The dew point is 4º right now.")
            Spacer()
        }.padding()
    }
}

struct Visibility2: View {
  @Binding var forecasts: [ForecastViewModel]
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "VISIBILITY", systemImage: "eye.fill")
                Spacer()
            }
            HeaderDivider()
          ButtonTitle(text: forecasts.first?.visibility ?? "Visibility")
            Spacer()
            
          ButtonDescription(text: forecasts.first?.visibilityDescription ??  "Visibility Description")
            
            Spacer()
        }.padding()
    }
}

struct Pressure2: View {
  @Binding var forecasts: [ForecastViewModel]
    var body: some View {
        VStack {
            HStack {
                ButtonHeader(text: "PRESSURE", systemImage: "gauge.medium")
                Spacer()
            }
            HeaderDivider()
          ButtonTitle(text: forecasts.first?.pressure ?? "Pressure")
          ButtonDescription(text: forecasts.first?.pressureDescription ?? "Pressure Description")
            
            Spacer()
        }.padding()
    }
}



