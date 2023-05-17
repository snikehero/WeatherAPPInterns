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
            .frame(width: 170, height: 170)
            .foregroundColor(.white)
            .background(Color("ButtonColor"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .opacity(60)
    }
    
}

struct ButtonHeader: View {
    
    var text: String
    var systemImage: String
    
    var body: some View {
        Label(text, systemImage: systemImage)
            .font(.caption)
            .opacity(0.60)
            .padding(.bottom, 1)
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
    var title: String
    var subtitle: String
    var description: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ButtonHeader(text: "UV INDEX", systemImage: "sun.max.fill")
                
            ButtonTitle(text: title)
            ButtonSubtitle(text: subtitle)
            ButtonDescription(text: description)
            Spacer()
        }
        .padding()
    }
}

struct Sunset: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ButtonHeader(text: "SUNSET", systemImage: "sunset.fill")
                Spacer()
            }
            ButtonTitle(text: title)
            ButtonDescription(text: description)
            Spacer()
        }.padding()
    }
}

struct Wind: View {
    var body: some View {
        VStack {
            HStack {
                ButtonHeader(text: "WIND", systemImage: "wind")
                Spacer()
            }
            Spacer()
        }.padding()
        
    }
}

struct Precipitation: View {
    var title: String
    var subtitle: String
    var description: String
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "PRECIPITATION", systemImage: "drop.fill")
                Spacer()
            }
            ButtonTitle(text: title)
            ButtonSubtitle(text: subtitle)
            Spacer()
            ButtonDescription(text: description)
            
            Spacer()
        }.padding()
    }
}

struct FeelsLike: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "FEELS LIKE", systemImage: "thermometer.medium")
                Spacer()
            }
            ButtonTitle(text: title)
            Spacer()
            ButtonDescription(text: description)
            
            Spacer()
        }.padding()
    }
}

struct Humidity: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "HUMIDITY", systemImage: "humidity")
                Spacer()
            }
            ButtonTitle(text: title)
            Spacer()
            
            ButtonDescription(text: description)
            Spacer()
        }.padding()
    }
}

struct Visibility: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "VISIBILITY", systemImage: "eye.fill")
                Spacer()
            }
            ButtonTitle(text: title)
            Spacer()
            
            ButtonDescription(text: description)
            
            Spacer()
        }.padding()
    }
}

struct Pressure: View {
    var body: some View {
        VStack {
            HStack {
                ButtonHeader(text: "PRESSURE", systemImage: "gauge.medium")
                Spacer()
            }
            Spacer()
        }.padding()
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
                            Sunset(title: "19:24", description: "Sunrise: 6:15")
                                .modifier(ExtraInfoButton())
                        }
                        
                    }
                    HStack {
                        // TRY CREATING A BUTTONVIEW RECEIVING CALLBACK
                        Button{
                            print("Wind")
                        } label: {
                            Wind()
                                .modifier(ExtraInfoButton())
                        }
                        
                        Button{
                            print("Precipitation")
                        } label: {
                            Precipitation(title: "0 mm", subtitle: "in last 24h", description: "None expected in next 10 days.")
                                .modifier(ExtraInfoButton())
                        }
                        
                        
                        
                    }
                    HStack {
                        Button{
                            print("FeelsLike")
                        } label: {
                            FeelsLike(title: "28º", description: "Wind is making it feel cooler")
                                .modifier(ExtraInfoButton())
                        }
                        
                        Button{
                            print("Humidity")
                        } label: {
                            Humidity(title: "20%", description: "The dew point is 4º right now.")
                                .modifier(ExtraInfoButton())
                        }
                        
                    }
                    HStack {
                        Button{
                            print("Visibility")
                        } label: {
                            Visibility(title: "25 km", description: "It's perfectly clear right now")
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



struct ButtonTitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.medium)
    }
}

struct ButtonSubtitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.medium)
    }
}

struct ButtonDescription: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .multilineTextAlignment(.leading)
    }
}
