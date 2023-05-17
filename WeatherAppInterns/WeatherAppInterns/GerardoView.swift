//
//  GerardoView.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 16/05/23.
//

import SwiftUI

struct ExtraInfoButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 130, height: 130)
            .foregroundColor(.white)
            .padding()
            .background(Color("ButtonColor"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .opacity(60)
    }
        
}

struct DailyForecast: View {
    var body: some View {
        Text("DailyForecast")
    }
}

struct TenDayForecast: View {
    var body: some View {
        Text("TenDayForecast")
    }
}

struct AirQuality: View {
    var body: some View {
        Text("AirQuality")
    }
    
}

struct PrecipitationMap: View {
    var body: some View {
        Text("PrecipitationMap")
    }
}

struct UVIndex: View {
    var body: some View {
        Text("UVIndex")
    }
}

struct Sunset: View {
    var body: some View {
        Text("Sunset")
    }
}

struct Wind: View {
    var body: some View {
        Text("Wind")
    }
}

struct Precipitation: View {
    var body: some View {
        Text("Precipitation")
    }
}

struct FeelsLike: View {
    var body: some View {
        Text("FeelsLike")
    }
}

struct Humidity: View {
    var body: some View {
        Text("Humidity")
    }
}

struct Visibility: View {
    var body: some View {
        Text("Visibility")
    }
}

struct Pressure: View {
    var body: some View {
        Text("pressure")
    }
}

struct GerardoView: View {
    var body: some View {
        
        
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
                .opacity(50)
            ScrollView (showsIndicators: false){
                VStack (spacing: 10){
                    DailyForecast()
                    TenDayForecast()
                    AirQuality()
                    PrecipitationMap()
                    HStack {
                        Button{
                            print("UVIndex")
                        } label: {
                            UVIndex()
                                .modifier(ExtraInfoButton())
                        }
                        
                        Button{
                            print("Sunset")
                        } label: {
                            Sunset()
                                .modifier(ExtraInfoButton())
                        }
                        
                    }
                    HStack {
                        Button{
                            print("Wind")
                        } label: {
                            Wind()
                                .modifier(ExtraInfoButton())
                        }
                        
                        Button{
                            print("Precipitation")
                        } label: {
                            Precipitation()
                                .modifier(ExtraInfoButton())
                        }
                        
                        
                        
                    }
                    HStack {
                        Button{
                            print("FeelsLike")
                        } label: {
                            FeelsLike()
                                .modifier(ExtraInfoButton())
                        }
                        
                        Button{
                            print("Humidity")
                        } label: {
                            Humidity()
                                .modifier(ExtraInfoButton())
                        }
                        
                    }
                    HStack {
                        Button{
                            print("Visibility")
                        } label: {
                            Visibility()
                                .modifier(ExtraInfoButton())
                        }
                        
                        Button{
                            print("Pressure")
                        } label: {
                            Pressure()
                                .modifier(ExtraInfoButton())
                        }
                        
                    }
                }
            }
            .padding()
            
        }
    }
}

struct GerardoView_Previews: PreviewProvider {
    static var previews: some View {
        GerardoView()
    }
}
