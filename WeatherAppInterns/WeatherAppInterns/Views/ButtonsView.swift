//
//  ButtonsView.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 18/05/23.
//

import SwiftUI

struct ExtraInfoButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 170, height: 170)
            .background(Color("ButtonColor"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .opacity(60)
    }
}

struct UVIndex: View {
    var title: String
    var subtitle: String
    var description: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ButtonHeader(text: "UV INDEX", systemImage: "sun.max.fill")
            
            HeaderDivider()
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
            HeaderDivider()
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
            HeaderDivider()
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
            HeaderDivider()
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
            HeaderDivider()
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
            HeaderDivider()
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
            HeaderDivider()
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
            HeaderDivider()
            Spacer()
        }.padding()
    }
}

struct ButtonsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
