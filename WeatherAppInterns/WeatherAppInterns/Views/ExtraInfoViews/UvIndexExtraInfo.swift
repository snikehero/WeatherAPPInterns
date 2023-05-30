//
//  uvIndexExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI

struct UvIndexExtraInfo: View {
    @Binding var isShowing : Bool
    @State private var selectedTab = 0
    @Binding var forecasts: [ForecastViewModel]
    @Binding var dailyForecasts: [DailyForecastViewModel]
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
                                  ButtonTitle(text: "\(dailyForecasts[selectedTab].uvi ) \(dailyForecasts[selectedTab].description )")
                                    ButtonSubtitle(text: "World Health Organization UVI")
                                }
                                Spacer()
                                ExtraInfoScreenPicker(selectedInfo: "UV Index")
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
                            
                          ExtraInfoSection(header: "Daily Summary", text: "\(dailyForecasts[selectedTab].description ). Levels of \(dailyForecasts[selectedTab].subtitle ) or higher are reached from 9:00 to 18:00.")
                            ExtraInfoSection(header: "About the UV Index", text: AboutConstants.uvIndex.rawValue)
                        }
                        .foregroundColor(.white)
                    }
                }	
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ExtraInfoHeader(systemImage: "sun.max.fill", title: "UV Index")
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

struct UvIndexExtraInfo_Previews: PreviewProvider {
    static private var isShowing = Binding.constant(false)

    static var previews: some View {
       // UvIndexExtraInfo(isShowing: isShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Sun protection recommended. Levels of Moderate or higher are reached from 9:00 to 18:00.", uvIndex: "3", uvIndexDescription: "Moderate")
      Text("hola")
    }
}
