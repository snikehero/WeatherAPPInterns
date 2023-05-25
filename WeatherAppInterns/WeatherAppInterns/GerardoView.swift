//
//  GerardoView.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 16/05/23.
//

import SwiftUI


struct HeaderDivider: View {
    var body: some View {
        Divider()
            .background(Color.white
                .opacity(0.6))
    }
}


struct PrecipitationMap: View {
    var body: some View {
        Text("PrecipitationMap")
    }
}


struct GerardoView: View {
    @State var isPrecipitationShowing = false
    @State var isVisibilityShowing = false
    @State var isWindShowing = false
    @State var isUVIndexShowing = false
    @State var isFeelsLikeShowing = false
    @State var isHumidityShowing = false
    @State var isPressureShowing = false
    
    var body: some View {
        
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
                .opacity(50)
            
            VStack {
                Spacer()
                ScrollView (showsIndicators: false){
                    
                    VStack (spacing: 10){
                        AngelView()
                        HStack (spacing: 15){
                            Button{
                                print("UVIndex")
                                isUVIndexShowing = true
                            } label: {
                                UVIndex(title: "11", subtitle: "Extreme", description: "Use sun protection until 17:00")
                                    .modifier(ExtraInfoButton())
                            }
                            
                            Button{
                                print("Sunset")
                            } label: {
                                Sunset(title: "19:24", description: "Sunrise: 6:15")
                                    .modifier(ExtraInfoButton())
                            }
                            
                        }
                        HStack {
                            // TRY CREATING A BUTTONVIEW RECEIVING CALLBACK
                            Button{
                                print("Wind")
                                isWindShowing = true
                            } label: {
                                Wind(title: "Wind", description: "0mm")
                                    .modifier(ExtraInfoButton())
                            }
                            
                            Button{
                                print("Precipitation")
                                isPrecipitationShowing = true
                            } label: {
                                Precipitation(title: "0 mm", subtitle: "in last 24h", description: "None expected in next 10 days.")
                                    .modifier(ExtraInfoButton())
                            }
                            
                        }
                        HStack {
                            Button{
                                print("FeelsLike")
                                isFeelsLikeShowing = true
                            } label: {
                                FeelsLike(title: "28º", description: "Wind is making it feel cooler")
                                    .modifier(ExtraInfoButton())
                            }
                            
                            Button{
                                print("Humidity")
                                isHumidityShowing = true
                            } label: {
                                Humidity(title: "20%", description: "The dew point is 4º right now.")
                                    .modifier(ExtraInfoButton())
                            }
                            
                        }
                        HStack {
                            Button{
                                print("Visibility")
                                isVisibilityShowing = true
                            } label: {
                                Visibility(title: "25 km", description: "It's perfectly clear right now")
                                    .modifier(ExtraInfoButton())
                            }
                            
                            Button{
                                print("Pressure")
                                isPressureShowing = true
                            } label: {
                                Pressure(title: "Presion", description: "descripcion")
                                    .modifier(ExtraInfoButton())
                            }
                            
                        }
                    }
                    .sheet(isPresented: $isPrecipitationShowing) {
                        PrecipitationExtraInfo(isPrecipitationShowing: $isPrecipitationShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "There has been 0 mm of precipitation in the last 24 hours. Today's total precipitation will be 0 mm", precipitation: "0mm")
                    }
                    .sheet(isPresented: $isVisibilityShowing) {
                        VisibilityExtraInfo(isVisibilityShowing: $isVisibilityShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Today, the visibility will be perfectly clear, at 26 to 26km", visibility: "10km")
                    }.sheet(isPresented: $isWindShowing) {
                        WindExtraInfo(isWindShowing: $isWindShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Wind is currently 14 km/h from the west-northwest. Today, wind speeds are 3 to 16 km/h, with gusts up to 34 km/h.", wind: "14 km/h", gusts: "31 km/h")
                    }.sheet(isPresented: $isFeelsLikeShowing) {
                        FeelsLikeExtraInfo(isFeelsLikeShowing: $isFeelsLikeShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "The temperature currently feels like 31º but it is actually 33º. Wind is making it feel cooler. Today's temperature range felt like 16º to 31º", feelsLike: "31", actual: "33")
                    }.sheet(isPresented: $isHumidityShowing) {
                        HumidityExtraInfo(isHumidityShowing: $isHumidityShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Today, the average humidity is 27%- The dew point is 1º to 6º", humidity: "27", dewPoint: "2")
                    }.sheet(isPresented: $isPressureShowing) {
                        PressureExtraInfo(isPressureShowing: $isPressureShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Pressure is currently 1,006 hPa and falling. Today, the average pressure will be 1,010 hPa, and the lowest pressure will be 1,006 hPa.", pressure: "1006")
                    }.sheet(isPresented: $isUVIndexShowing) {
                        UvIndexExtraInfo(isUVIndexShowing: $isUVIndexShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Sun protection recommended. Levels of Moderate or higher are reached from 9:00 to 18:00.", uvIndex: "3", uvIndexDescription: "Moderate")
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    NavBarView()
                }
            }
            
        }
    }
    
}

struct GerardoView_Previews: PreviewProvider {
    static var previews: some View {
        GerardoView()
    }
}




