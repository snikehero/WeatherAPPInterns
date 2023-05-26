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
            .background(.ultraThinMaterial)
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
  var title: String
  var description: String
    var degrees: String
    
    var body: some View {
        
            ZStack {
                VStack {
                    Spacer()
                    Image("Compass")
                        .resizable()
                        .frame(maxWidth: 130, maxHeight: 130)
                    .modifier(ExtraInfoButton())
                }
                    
                Image("Arrow")
                    .rotationEffect(.degrees(Double(degrees) ?? 0))
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
  var title: String
  var description: String
    var body: some View {
        VStack {
            HStack {
                ButtonHeader(text: "PRESSURE", systemImage: "gauge.medium")
                Spacer()
            }
            HeaderDivider()
          ButtonTitle(text: title)
          ButtonDescription(text: description)
            
            Spacer()
        }.padding()
    }
}

struct XMarkButton: View {
    var body: some View {
        Image(systemName: "xmark")
            .font(.headline)
            .foregroundColor(Color("ButtonFilledTextColor"))
            .frame(width: 30, height: 30)
            .background(
                Circle()
                    .fill(Color("ButtonFilledBackgroundColor"))
            )
    }
}

struct SelectedRoundedFill: View {
    var text: String
    var body: some View{
        Text(text)
            .fontWeight(.semibold)
            .padding()
            .foregroundColor(Color("ExtraInfoBackgroundColor"))
            
            .background(
                Circle()
                    .fill(.white)
                    .frame(maxWidth: 30, maxHeight: 30)
                )
    }
}
struct AirPollutionView: View {
  var title: String
  var subtitle: String
  var description: String
    var body: some View {
      VStack(alignment: .leading) {
        ButtonHeader(text: "Air Quality".uppercased(), systemImage: "aqi.medium")
        HeaderDivider()
        ButtonSubtitle(text: subtitle)
        ButtonDescription(text: description)
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

struct ButtonsView: View {
    var body: some View {
        Wind(title: "Wind", description: "0mm", degrees: "90")
            .modifier(ExtraInfoButton())
//        XMarkButton()
      AirPollutionView(title: "", subtitle: "", description: "")
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
