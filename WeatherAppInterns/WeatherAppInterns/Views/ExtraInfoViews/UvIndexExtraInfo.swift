//
//  uvIndexExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI

struct UvIndexExtraInfo: View {
    @Binding var isUVIndexShowing : Bool
    @State private var selectedTab = 0

    var currentDay: String
    var numberDay: Int
    var date: Date
    var dailySummary: String
    var uvIndex: String
    var uvIndexDescription: String // Calculated value
    
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
                                    ButtonTitle(text: "\(uvIndex) \(uvIndexDescription)")
                                    ButtonSubtitle(text: "World Health Organization UVI")
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
                        isUVIndexShowing = false
                    } label: {
                        XMarkButton()
                    }
                }
            }
        }

    }
}

struct UvIndexExtraInfo_Previews: PreviewProvider {
    static private var isUVIndexShowing = Binding.constant(false)

    static var previews: some View {
        UvIndexExtraInfo(isUVIndexShowing: isUVIndexShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Sun protection recommended. Levels of Moderate or higher are reached from 9:00 to 18:00.", uvIndex: "3", uvIndexDescription: "Moderate")
    }
}
