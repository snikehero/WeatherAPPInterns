//
//  windExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI
import Charts

struct WindExtraInfo: View {
    @Binding var isWindShowing : Bool
    @State private var selectedTab = 0

    var currentDay: String
    var numberDay: Int
    var date: Date
    var dailySummary: String
    var wind: String
    var gusts: String
    
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
                                    ButtonTitle(text: wind)
                                    ButtonSubtitle(text: "Gusts: \(gusts)")
                                }
                                Spacer()
                                ExtraInfoScreenPicker()
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
                        isWindShowing = false
                    } label: {
                        XMarkButton()
                    }
                }
            }
        }
    }
}

struct WindExtraInfo_Previews: PreviewProvider {
    static private var isWindShowing = Binding.constant(false)
    static var previews: some View {
        WindExtraInfo(isWindShowing: isWindShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Wind is currently 14 km/h from the west-northwest. Today, wind speeds are 3 to 16 km/h, with gusts up to 34 km/h.", wind: "14 km/h", gusts: "31 km/h")
    }
}
