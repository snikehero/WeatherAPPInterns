//
//  PressureExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI

struct PressureExtraInfo: View {
    @Binding var isShowing : Bool
    @State private var selectedTab = 0
//    @Binding var forecasts: [ForecastViewModel]
//    @Binding var dailyForecasts: [DailyForecastViewModel]
    @EnvironmentObject var forecastListVM: CityForecastModel
    @EnvironmentObject var dailyForecastListVM: DailyForecastListViewmodel
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
                                          Text(dailyForecastListVM.dailyForecasts[element].exactDayName)
                                                .fontWeight(.semibold)
                                            Button(action: {
                                                selectedTab = element // Cambiar a la pestaña 0
                                            }) {
                                                if selectedTab == element {
                                                  SelectedRoundedFill(text: String(dailyForecastListVM.dailyForecasts[element].dayNumber))
                                                } else {
                                                    
                                                  Text(String(dailyForecastListVM.dailyForecasts[element].dayNumber))
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
                                  ButtonTitle(text: "\(dailyForecastListVM.dailyForecasts[selectedTab].pressure) hPa")

                                }
                                Spacer()
                                ExtraInfoScreenPicker(selectedInfo: $selectedSheet)
                            }.padding(.leading)
                            
                           
                            TabView(selection: $selectedTab) {
                                ForEach(0..<11){ i in
                                    PressureChartMock()
                                        .tabItem {
                                            EmptyView()
                                        }
                                        .tag(i)
                                }
                            }
                            .frame(width: 300, height: 300)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                          ExtraInfoSection(header: "Daily Summary", text: "Pressure is currently \(dailyForecastListVM.dailyForecasts[selectedTab].pressure ) hPa and falling. Today, the average pressure will be \(dailyForecastListVM.dailyForecasts[selectedTab].pressure) hPa,")
                            ExtraInfoSection(header: "About Pressure", text: AboutConstants.pressure.rawValue)
                        }
                        .foregroundColor(.white)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ExtraInfoHeader(systemImage: "gauge", title: "Pressure")
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

struct PressureExtraInfo_Previews: PreviewProvider {
    static private var isShowing = Binding.constant(false)
    static var previews: some View {
        //PressureExtraInfo(isShowing: isShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Pressure is currently 1,006 hPa and falling. Today, the average pressure will be 1,010 hPa, and the lowest pressure will be 1,006 hPa.", pressure: "String")
      Text("Prueba")
    }
}
