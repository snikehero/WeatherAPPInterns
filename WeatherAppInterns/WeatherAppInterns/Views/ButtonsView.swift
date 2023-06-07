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
    @EnvironmentObject var forecastListVM: CityForecastModel
    //@Binding var forecasts: [ForecastViewModel]
    var testing = false
    var body: some View{
        VStack{
          ButtonDescription(text: "\(forecastListVM.forecasts.first?.weatherDescription ?? "Cloudy conditions") expected")
            HeaderDivider()
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    
                  ForEach($forecastListVM.forecasts, id: \.id) { element in
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
  @EnvironmentObject var forecastListVM: CityForecastModel
  //@Binding var forecasts: [ForecastViewModel]
    //var cityName: String
    var body: some View{
        VStack{
          TitleText(text: forecastListVM.city.cityName)
          BigNumberText(text: "\(forecastListVM.forecasts.first?.current ?? "0")º")
            HStack{
              ButtonSubtitle(text: "Low: \(forecastListVM.forecasts.first?.low ?? "0")º")
                    .shadow(color: .black ,radius: 15, x: 2, y: 2)
              ButtonSubtitle(text: "High: \(forecastListVM.forecasts.first?.high ?? "0")º")
                    .shadow(color: .black ,radius: 15, x: 2, y: 2)
            }
        }
        
        
    }
}
struct DaysView: View{
  @EnvironmentObject var dailyForecastListVM: DailyForecastListViewmodel
    //@Binding var dailyForecasts: [DailyForecastViewModel]
    var body: some View{
      ForEach($dailyForecastListVM.dailyForecasts, id: \.id) { element in
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
                        TempSlider(value: "\(element.wrappedValue.current)", minValue: "\(element.wrappedValue.minTemp)", maxValue: "\(element.wrappedValue.maxTemp)")
                        //                        NormalText(text: element.wrappedValue.minTemp)
                        //                        Spacer()
                        //                        NormalText(text: "------")
                        //                        Spacer()
                        //                        //maxtemp
                        //                        NormalText(text: element.wrappedValue.maxTemp)
                    }
                }
            }
        }
    }
}
struct AirPollutionView: View {
  @EnvironmentObject var airPollutionListVM: AirPollutionListViewModel
    //@Binding var airPollution: [AirPollutionViewModel]
    var body: some View {
        VStack(alignment: .leading) {
            ButtonHeader(text: "Air Quality".uppercased(), systemImage: "aqi.medium")
            HeaderDivider()
          ButtonSubtitle(text: airPollutionListVM.airPollutions.first?.index  ?? "0")
          ButtonDescription(text: airPollutionListVM.airPollutions.first?.airPollutionDescription ?? "0")
          AirQualitySlider(value: airPollutionListVM.airPollutions.first?.index ?? "0")
          //ButtonSubtitle(text: airPollutionListVM.airPollutions.airPollution.first?.index ?? "0")
          //ButtonDescription(text: $airPollutionListVM.airPollutions.airPollution.first?.airPollutionDescription ?? "0")
          //AirQualitySlider(value: $airPollutionListVM.airPollutions.airPollution.first?.index ?? "0")
          //agregar la grafica y modificar su valor dependiendo de airpollution.indexRectangle()
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
    @EnvironmentObject var dailyForecastListVM: DailyForecastListViewmodel
    //@Binding var dailyForecasts: [DailyForecastViewModel]
    var body: some View {
        
        VStack(alignment: .leading) {
            ButtonHeader(text: "UV INDEX", systemImage: "sun.max.fill")
            
            HeaderDivider()
          ButtonTitle(text: dailyForecastListVM.dailyForecasts.first?.uvi ?? "UVI")
          ButtonSubtitle(text: dailyForecastListVM.dailyForecasts.first?.subtitle ?? "Subitle")
          ButtonDescription(text: dailyForecastListVM.dailyForecasts.first?.description ?? "Description")
            Spacer()
        }
        .padding()
    }
}

struct Sunset: View {
    @EnvironmentObject var forecastListVM: CityForecastModel
  //@Binding var forecasts: [ForecastViewModel]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ButtonHeader(text: "SUNSET", systemImage: "sunset.fill")
                Spacer()
            }
            HeaderDivider()
          ButtonTitle(text: forecastListVM.city.sunset)
          ButtonDescription(text: "Sunrise: \(forecastListVM.city.sunrise)")
            Spacer()
        }.padding()
    }
}

struct Wind: View {
    @EnvironmentObject var dailyForecastListVM: DailyForecastListViewmodel
    @EnvironmentObject var forecastListVM: CityForecastModel
  //  @Binding var forecasts: [ForecastViewModel]
  //  @Binding var dailyForecasts: [DailyForecastViewModel]
    var body: some View {
        
        ZStack {
            Image("Compass")
                .resizable()
                .frame(maxWidth: 130, maxHeight: 130)
                .padding(.top, 30)
            Image("Arrow")
            .rotationEffect(.degrees(Double(dailyForecastListVM.dailyForecasts.first?.windDeg ?? "0") ?? 0))
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
    @EnvironmentObject var dailyForecastListVM: DailyForecastListViewmodel
    @EnvironmentObject var forecastListVM: CityForecastModel
  //  @Binding var forecasts: [ForecastViewModel]
  //  @Binding var dailyForecasts: [DailyForecastViewModel]
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "PRECIPITATION", systemImage: "drop.fill")
                Spacer()
            }
            HeaderDivider()
          ButtonTitle(text: dailyForecastListVM.dailyForecasts.first?.pop ?? "Precipitation")
            ButtonSubtitle(text: "in last 24 h")
            Spacer()
          ButtonDescription(text: forecastListVM.forecasts.first?.popDescription ?? "POP description")
            
            Spacer()
        }.padding()
    }
}

struct FeelsLike: View {
    @EnvironmentObject var forecastListVM: CityForecastModel
  //@Binding var forecasts: [ForecastViewModel]
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "FEELS LIKE", systemImage: "thermometer.medium")
                Spacer()
            }
            HeaderDivider()
          ButtonTitle(text: "\(forecastListVM.forecasts.first?.fellsLike ?? "feelslike")º")
            Spacer()
          ButtonDescription(text: forecastListVM.forecasts.first?.feelsLikeDescription ?? "feelslikedescription")
            
            Spacer()
        }.padding()
    }
}

struct Humidity: View {
    @EnvironmentObject var dailyForecastListVM: DailyForecastListViewmodel
    @EnvironmentObject var forecastListVM: CityForecastModel
//  @Binding var forecasts: [ForecastViewModel]
//  @Binding var dailyForecasts: [DailyForecastViewModel]
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "HUMIDITY", systemImage: "humidity")
                Spacer()
            }
            HeaderDivider()
          ButtonTitle(text: "\(dailyForecastListVM.dailyForecasts.first?.humidity ?? "Humidity")%")
            Spacer()
            
          ButtonDescription(text: "The dew point is \(dailyForecastListVM.dailyForecasts.first?.dew_point ?? "0")º right now.")
            Spacer()
        }.padding()
    }
}

struct Visibility: View {
    @EnvironmentObject var forecastListVM: CityForecastModel
    //@Binding var forecasts: [ForecastViewModel]
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                ButtonHeader(text: "VISIBILITY", systemImage: "eye.fill")
                Spacer()
            }
            HeaderDivider()
          ButtonTitle(text: "\(forecastListVM.forecasts.first?.visibility ?? "Visibility")Km")
            Spacer()
            
          ButtonDescription(text: forecastListVM.forecasts.first?.visibilityDescription ??  "Visibility Description")
            
            Spacer()
        }.padding()
    }
}

struct Pressure: View {
    @EnvironmentObject var dailyForecastListVM: DailyForecastListViewmodel
    @EnvironmentObject var forecastListVM: CityForecastModel
    //@Binding var forecasts: [ForecastViewModel]
    //@Binding var dailyForecasts: [DailyForecastViewModel]
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
          PressureGauge(value: dailyForecastListVM.dailyForecasts.first?.pressure ?? "1000")
            
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
    @Binding var selectedInfo: showingSheets
    var body: some View {
        Picker("Picker", selection: $selectedInfo) {
            ForEach(showingSheets.allCases){e in
                Text("\(e.rawValue)").tag(e.rawValue)
            }
        }.foregroundColor(.white)
    }
}

struct AirQualitySlider: View {
    var value: String
    
    var body: some View{
        let valueDouble = Double(value) ?? 0.0
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
            Text("Pressure")
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

struct TempSlider: View {
    var value: String
    var minValue: String
    var maxValue: String
    
    
    var body: some View{
        let valueDouble = Double(value) ?? 0.0
        let minValueDouble = Double(minValue) ?? 0.0
        let maxValueDouble = Double(maxValue) ?? 0.0
        let colors: [Color] = maxValueDouble <= 15 ? [Color(hue: 0.583, saturation: 0.82, brightness: 0.88)] : [.yellow, .orange, .red]
        
        HStack {
            Text("\(minValue)º")
                .foregroundColor(.white)
            
            Gauge(value: valueDouble, in: minValueDouble...maxValueDouble) {
                Text("Temperature \(value)")
            }
            .gaugeStyle(.accessoryLinear)
            .tint(Gradient(colors: colors))
            
            Text("\(maxValue)º")
                .foregroundColor(.white)
        }
        .frame(width: 150)
    }
}

struct ButtonsView: View {
    
    var body: some View {
        ZStack {
            //            AirQualitySlider(value: "2.5")
            //            PressureGauge(value: "1010")
            TempSlider(value: "25", minValue: "16", maxValue: "27")
        }
        
        
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}



