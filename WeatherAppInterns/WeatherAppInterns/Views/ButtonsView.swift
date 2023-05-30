//
//  ButtonsView.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 18/05/23.
//

import SwiftUI

struct HeaderDivider: View {
    var body: some View {
        Divider()
            .background(Color.white
                .opacity(0.6))
    }
}

struct ExtraInfoButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 170, height: 170)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .opacity(60)
    }
}

struct HourlyView: View{
    @Binding var forecasts: [ForecastViewModel]
    var testing = false
    var body: some View{
        VStack{
            ButtonDescription(text: "\(forecasts.first?.weatherDescription ?? "Cloudy conditions") expected")
            HeaderDivider()
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    
                    ForEach($forecasts, id: \.id) { element in
                        VStack(spacing: 10) {
                            NormalText(text: element.wrappedValue.hourDay)
                            NormalText(text: element.wrappedValue.emoji)
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
struct SummaryView: View{
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
struct DaysView: View{
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
                        NormalText(text: element.wrappedValue.emoji)
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
struct AirPollutionView: View {
    @Binding var airPollution: [AirPollutionViewModel]
    var body: some View {
        VStack(alignment: .leading) {
            ButtonHeader(text: "Air Quality".uppercased(), systemImage: "aqi.medium")
            HeaderDivider()
            ButtonSubtitle(text: airPollution.first?.index ?? "0")
            ButtonDescription(text: airPollution.first?.airPollutionDescription ?? "0")
            //agregar la grafica y modificar su valor dependiendo de airpollution.indexRectangle()
            AirQualitySlider(value: airPollution.first?.index ?? "0")
            
        }
        .frame(maxWidth: 350)
        .multilineTextAlignment(.leading)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}
//Buttons View
struct UVIndex: View {
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
    @Binding var forecasts: [ForecastViewModel]
    @Binding var dailyForecasts: [DailyForecastViewModel]
    var body: some View {
        
        ZStack {
            Image("Compass")
                .resizable()
                .frame(maxWidth: 130, maxHeight: 130)
                .padding(.top, 30)
            Image("Arrow")
                .rotationEffect(.degrees(Double(dailyForecasts.first?.windDeg ?? "0") ?? 0))
                .padding(.top, 15)
            Text("34")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 25)
            
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
    @Binding var forecasts: [ForecastViewModel]
    @Binding var dailyForecasts: [DailyForecastViewModel]
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "PRECIPITATION", systemImage: "drop.fill")
                Spacer()
            }
            HeaderDivider()
            ButtonTitle(text: dailyForecasts.first?.pop ?? "Precipitation")
            ButtonSubtitle(text: "in last 24 h")
            Spacer()
            ButtonDescription(text: forecasts.first?.popDescription ?? "POP description")
            
            Spacer()
        }.padding()
    }
}

struct FeelsLike: View {
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

struct Humidity: View {
    @Binding var forecasts: [ForecastViewModel]
    @Binding var dailyForecasts: [DailyForecastViewModel]
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "HUMIDITY", systemImage: "humidity")
                Spacer()
            }
            HeaderDivider()
            ButtonTitle(text: dailyForecasts.first?.humidity ?? "Humidity")
            Spacer()
            
            ButtonDescription(text: "The dew point is \(dailyForecasts.first?.dew_point ?? "0")º right now.")
            Spacer()
        }.padding()
    }
}

struct Visibility: View {
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

struct Pressure: View {
    @Binding var forecasts: [ForecastViewModel]
    @Binding var dailyForecasts: [DailyForecastViewModel]
    var body: some View {
        VStack {
            HStack {
                ButtonHeader(text: "PRESSURE", systemImage: "gauge.medium")
                Spacer()
            }
            HeaderDivider()
            Spacer()
//            ButtonTitle(text: dailyForecasts.first?.pressure ?? "Pressure")
//            ButtonDescription(text: forecasts.first?.pressureDescription ?? "Pressure Description")
            PressureGauge(value: dailyForecasts.first?.pressure ?? "1000")
            
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

struct ExtraInfoScreenPicker: View {
    @State var selectedInfo: String
    var body: some View {
        Picker("Picker", selection: $selectedInfo) {
            ForEach(ExtraInfo.allCases){e in
                Text("\(e.rawValue)").tag(e.rawValue)
            }
        }.foregroundColor(.white)
    }
}

struct AirQualitySlider: View {
    var value: String
    
    var body: some View{
        var valueDouble = Double(value) ?? 0.0
        Gauge(value: valueDouble, in: 0...5) {
            Text("Label")
        }
        .gaugeStyle(.accessoryLinear)
        .tint(Gradient(colors: [.green, .yellow, .orange, .red, .purple]))
        .frame(width: 300)
    }
}

struct PressureGauge: View {
    var value: String
    
    var body: some View{
        let valueDouble = Double(value) ?? 0.0
        
            Gauge(value: valueDouble, in: 0...2000) {
                Text("Label")
            } currentValueLabel: {
                Text(value)
            } minimumValueLabel: {
                Text("L")
            } maximumValueLabel: {
                Text("H")
            }
            .gaugeStyle(.accessoryCircular)
            .tint(.white)
            .scaleEffect(1.8)
        
    }
}

struct ButtonsView: View {
    
    var body: some View {
        ZStack {
//            AirQualitySlider(value: "2.5")
            PressureGauge(value: "1010")
        }
        
        
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}



