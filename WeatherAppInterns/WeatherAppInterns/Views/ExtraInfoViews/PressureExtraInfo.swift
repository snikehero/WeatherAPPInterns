//
//  PressureExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI

struct PressureExtraInfo: View {
    @Binding var isPressureShowing : Bool
    @State private var selectedTab = 0

    var currentDay: String
    var numberDay: Int
    var date: Date
    var dailySummary: String
    var pressure: String
    
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
                                    ButtonTitle(text: "\(pressure) hPa")

                                }
                                Spacer()
                                ExtraInfoScreenPicker(selectedInfo: "Pressure")
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
                        isPressureShowing = false
                    } label: {
                        XMarkButton()
                    }
                }
            }
        }
    }
}

struct PressureExtraInfo_Previews: PreviewProvider {
    static private var isPressureShowing = Binding.constant(false)
    static var previews: some View {
        PressureExtraInfo(isPressureShowing: isPressureShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Pressure is currently 1,006 hPa and falling. Today, the average pressure will be 1,010 hPa, and the lowest pressure will be 1,006 hPa.", pressure: "String")
    }
}
