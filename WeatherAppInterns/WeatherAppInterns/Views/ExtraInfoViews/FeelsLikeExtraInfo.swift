//
//  feelsLikeExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI
import Charts

struct FeelsLikeExtraInfo: View {
    @Binding var isFeelsLikeShowing : Bool
    @State private var selectedTab = 0

    var currentDay: String
    var numberDay: Int
    var date: Date
    var dailySummary: String
    var feelsLike: String
    var actual: String
    
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
                                    ButtonTitle(text: "\(feelsLike)º")
                                    ButtonSubtitle(text: "Actual \(actual)º")
                                }
                                Spacer()
                                ExtraInfoScreenPicker(selectedInfo: "Feels Like")
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
                        isFeelsLikeShowing = false
                    } label: {
                        XMarkButton()
                    }
                }
            }
        }
    }

    }


struct FeelsLikeExtraInfo_Previews: PreviewProvider {
    static private var isFeelsLikeShowing = Binding.constant(false)
    static var previews: some View {
      FeelsLikeExtraInfo(isFeelsLikeShowing: isFeelsLikeShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "The temperature currently feels like 31º but it is actually 33º. Wind is making it feel cooler. Today's temperature range felt like 16º to 31º", feelsLike: "31", actual: "33")
    }
}
