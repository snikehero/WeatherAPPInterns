//
//  windExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI
import Charts

struct WindExtraInfo: View {
    @Binding var isShowing : Bool
    @State private var selectedTab = 0
    @Binding var forecasts: [ForecastViewModel]
    @Binding var dailyForecasts: [DailyForecastViewModel]
    @Binding var selectedSheet: showingSheets
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("ExtraInfoBackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView {
                        VStack {
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    ForEach(0..<7) { element in
                                        VStack(spacing : 1){
                                            Text(dailyForecasts[element].exactDayName)
                                                .fontWeight(.semibold)
                                            Button(action: {
                                                selectedTab = element // Cambiar a la pestaña 0
                                            }) {
                                                if selectedTab == element {
                                                    SelectedRoundedFill(text: String(dailyForecasts[element].dayNumber))
                                                } else {
                                                    
                                                    Text(String(dailyForecasts[element].dayNumber))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(.white)
                                                        .padding()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Text(Date(), style: .date)
                            HeaderDivider().padding()
                            HStack {
                                VStack (alignment: .leading){
                                  ButtonTitle(text: "\(dailyForecasts[selectedTab].windSpeed )km/h")
                                  ButtonSubtitle(text: "Gusts: \(dailyForecasts[selectedTab].windGust)")
                                }
                                Spacer()
                                ExtraInfoScreenPicker(selectedInfo: $selectedSheet)
                            }.padding(.leading)
                            
                           
                            TabView(selection: $selectedTab) {
                                ForEach(0..<11){ i in
                                    ChartMock()
                                        .tabItem {
                                            EmptyView()
                                        }
                                        .tag(i)
                                }
                            }
                            .frame(width: 300, height: 300)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                          ExtraInfoSection(header: "Daily Summary", text: "Wind is currently \(dailyForecasts[selectedTab].windSpeed ) km/h from the west-northwest. Today, wind speeds are \(dailyForecasts[selectedTab].windSpeed ) km/h to \(forecasts.last?.windSpeed ?? "0") km/h, with gusts up to \(dailyForecasts[selectedTab].windGust ) km/h.")
                            ExtraInfoSection(header: "About Wind Speed and Gusts", text: AboutConstants.wind.rawValue)
                            
                        }
                        .foregroundColor(.white)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ExtraInfoHeader(systemImage: "wind", title: "Wind")
                }
                ToolbarItem(placement: .primaryAction) {
                    Button{
                        isShowing.toggle()
                    } label: {
                        XMarkButton()
                    }
                }
            }
        }
    }
}

struct WindExtraInfo_Previews: PreviewProvider {
    static private var isShowing = Binding.constant(false)
    static var previews: some View {
        //WindExtraInfo(isShowing: isShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Wind is currently 14 km/h from the west-northwest. Today, wind speeds are 3 to 16 km/h, with gusts up to 34 km/h.", wind: "14 km/h", gusts: "31 km/h")
      Text("Prueba")
    }
}
