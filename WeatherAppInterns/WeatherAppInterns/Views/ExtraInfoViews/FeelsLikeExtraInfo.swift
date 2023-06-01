//
//  feelsLikeExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI
import Charts

struct FeelsLikeExtraInfo: View {
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
                                  ButtonTitle(text: "\(forecasts.first?.fellsLike ?? "0")º")
                                  ButtonSubtitle(text:"Actual \(forecasts.first?.current ?? "0")")
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
                            
                          ExtraInfoSection(header: "Daily Summary", text: "The temperature currently feels like \(forecasts.first?.fellsLike ?? "0")º but it is actually \(forecasts.first?.current ?? "0")º. \(forecasts.first?.feelsLikeDescription ?? "0").")
                            ExtraInfoSection(header: "About the Feels Like Temperature", text: AboutConstants.feelsLike.rawValue)
                            
                        }
                        .foregroundColor(.white)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ExtraInfoHeader(systemImage: "thermometer", title: "Feels Like")
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


struct FeelsLikeExtraInfo_Previews: PreviewProvider {
    static private var isShowing = Binding.constant(false)
    static var previews: some View {
      //FeelsLikeExtraInfo(isShowing: isShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "The temperature currently feels like 31º but it is actually 33º. Wind is making it feel cooler. Today's temperature range felt like 16º to 31º", feelsLike: "31", actual: "33")
      Text("hola")
    }
}
