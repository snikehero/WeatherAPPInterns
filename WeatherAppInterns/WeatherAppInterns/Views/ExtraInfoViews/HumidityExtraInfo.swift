//
//  humidityExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI

struct HumidityExtraInfo: View {
    @Binding var isShowing : Bool
    @State private var selectedTab = 0

    var currentDay: String
    var numberDay: Int
    var date: Date
    var dailySummary: String
    var humidity: String
    var dewPoint: String
    
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
                                    ForEach(0..<10) { element in
                                        VStack(spacing : 1){
                                            Text(currentDay)
                                                .fontWeight(.semibold)
                                            Button(action: {
                                                selectedTab = element // Cambiar a la pestaña 0
                                            }) {
                                                if selectedTab == element {
                                                    SelectedRoundedFill(text: String(numberDay))
                                                } else {
                                                    
                                                    Text(String(numberDay))
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
                                    ButtonTitle(text: "\(humidity)%")
                                    ButtonSubtitle(text: "Dew point:  \(dewPoint)º")
                                }
                                Spacer()
                                ExtraInfoScreenPicker(selectedInfo: "Humidity")
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
                            
                            ExtraInfoSection(header: "Daily Summary", text: dailySummary)
                            ExtraInfoSection(header: "About the Relative Humidity", text: AboutConstants.humidity.rawValue)
                            ExtraInfoSection(header: "About the Dew Point", text: AboutConstants.dewPoint.rawValue)
                            
                        }
                        .foregroundColor(.white)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ExtraInfoHeader(systemImage: "humidity", title: "Humidity")
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

struct HumidityExtraInfo_Previews: PreviewProvider {
    static private var isShowing = Binding.constant(false)
    static var previews: some View {
        HumidityExtraInfo(isShowing: isShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Today, the average humidity is 27%- The dew point is 1º to 6º", humidity: "27", dewPoint: "2")
    }
}


