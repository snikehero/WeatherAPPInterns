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
                Spacer()
                NavBarView()
            }
            
        }
    }
    
}

struct GerardoView_Previews: PreviewProvider {
    static var previews: some View {
        GerardoView()
    }
}




