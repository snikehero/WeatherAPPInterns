

import SwiftUI
import CoreLocation
import Combine


struct DemoView3: View {
  @StateObject var forecastListVM = ForecastListViewModel()
  @StateObject var deviceLocationService = DeviceLocationService.shared
  @StateObject private var dailyForecastListVM = DailyForecastListViewmodel()
  @State var tokens: Set<AnyCancellable> = []
  @State var coordinates: (lat: Double, lon: Double) = (0,0)
  @State var selectedSheet: showingSheets = .precipitation
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
        //BackgroundView()x
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
                      //                      Button {
                      //                        forecastListVM.getWeatherForecast()
                      //                        forecastListVM.getCity()
                      //                        dailyForecastListVM.getDailyWeatherForecast()
                      //                        forecastListVM.location = "location"
                      //                        dailyForecastListVM.location = "location"
                      //                        airPollutionListVM.getAirPollution()
                      //                      } label: {
                      //                        Image(systemName: "magnifyingglass.circle.fill")
                      //                          .font(.title3)
                      //                      }
                      Button {
                        selectedSheet = .airQuality
                        isShowing.toggle()
                      }label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                          .font(.title3)
                      }
                        SummaryView(forecasts: $forecastListVM.forecasts,cityName: forecastListVM.city.cityName)
                        ButtonSubtitle(text: forecastListVM.forecasts.first?.overview ?? "overview")
                          .shadow(color: .black ,radius: 15, x: 2, y: 2)
                        HourlyView(forecasts: $forecastListVM.forecasts)
                        AirPollutionView(airPollution: $airPollutionListVM.airPollutions)
                        VStack(alignment: .leading, spacing: 10){
                          ButtonHeader(text: "8 - DAY FORECAST", systemImage: "calendar")
                          HeaderDivider()
                          DaysView(dailyForecasts: $dailyForecastListVM.dailyForecasts)
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
                    UVIndex(dailyForecasts: $dailyForecastListVM.dailyForecasts)
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
                  Button{
                    print("Wind")
                    selectedSheet = .wind
                    isShowing.toggle()
                  } label: {
                    Wind(forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
                      .modifier(ExtraInfoButton())
                  }
                  Button{
                    print("Precipitation")
                    selectedSheet = .precipitation
                    isShowing.toggle()
                  } label: {
                    Precipitation(forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
                      .modifier(ExtraInfoButton())
                  }
                }
                HStack {
                  Button{
                    print("FeelsLike")
                    selectedSheet = .feelsLike
                    isShowing.toggle()
                  } label: {
                    FeelsLike(forecasts: $forecastListVM.forecasts)
                      .modifier(ExtraInfoButton())
                  }
                  Button{
                    print("Humidity")
                    selectedSheet = .humidity
                    isShowing.toggle()
                  } label: {
                    Humidity(forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
                      .modifier(ExtraInfoButton())
                  }
                }
                HStack {
                  Button{
                    print("Visibility")
                    selectedSheet = .visibility
                    isShowing.toggle()
                  } label: {
                    Visibility(forecasts: $forecastListVM.forecasts)
                      .modifier(ExtraInfoButton())
                  }
                  Button{
                    print("Pressure")
                    selectedSheet = .pressure
                    isShowing.toggle()
                  } label: {
                    Pressure(forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
                      .modifier(ExtraInfoButton())
                  }
                }
              }
              .sheet(isPresented: $isShowing){
                switch selectedSheet {
                case .precipitation:
                  PrecipitationExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
                case .visibility:
                  VisibilityExtraInfo(isShowing: $isShowing,forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
                case .wind:
                  WindExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
                case .uvIndex:
                  UvIndexExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
                case .feelsLike:
                  FeelsLikeExtraInfo(isShowing: $isShowing,forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
                case .humidity:
                  HumidityExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts)
                case .pressure:
                  PressureExtraInfo(isShowing: $isShowing,forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts )
                case .airQuality:
                  AirQualityExtraInfo(isShowing: $isShowing, airQuality: $airPollutionListVM.airPollutions)
                }
                
                
              }
              
            }
            .onAppear(){
              observeCoordinatesUpdates()
              observeLocationAccessDenied()
              deviceLocationService.requestLocationUpdates()
              
            }
            Spacer()
          }
          
          
        }
        .toolbar{
          ToolbarItemGroup(placement: .bottomBar){
            NavBarView()
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
          forecastListVM.getWeatherForecast()
          forecastListVM.getCity()
          dailyForecastListVM.getDailyWeatherForecast()
          forecastListVM.location = "location"
          dailyForecastListVM.location = "location"
          airPollutionListVM.getAirPollution()
        }
        .store(in: &tokens)
    }
    func observeLocationAccessDenied() {
      deviceLocationService.deniedLocationAccessPublisher
        .receive(on: DispatchQueue.main)
        .sink {
          print("Show some kind of alert to the user")
          self.coordinates = (37.3230,-122.0322)
          forecastListVM.coordinates = (37.3230,-122.0322)
          forecastListVM.getWeatherForecast()
          forecastListVM.getCity()
          dailyForecastListVM.getDailyWeatherForecast()
          forecastListVM.location = "location"
          dailyForecastListVM.location = "location"
          airPollutionListVM.getAirPollution()
        }
        .store(in: &tokens)
    }
  }
  struct DemoView3_Previews: PreviewProvider {
    static var previews: some View {
      DemoView3()
        .background(Color("BackgroundColor"))
    }
  }
  
  
  
