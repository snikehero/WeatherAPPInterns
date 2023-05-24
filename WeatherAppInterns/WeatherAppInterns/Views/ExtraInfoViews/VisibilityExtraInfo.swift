//
//  visibilityExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI
import Charts

struct VisibilityExtraInfo: View {
    @Binding var isVisibilityShowing : Bool
    @State private var selectedTab = 0

    var currentDay: String
    var numberDay: Int
    var date: Date
    var dailySummary: String
    var visibility: String
    
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
                                    ButtonTitle(text: visibility)
                                    ButtonSubtitle(text: "PERFECTLY CLEAR")
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
                            
                            NormalText(text: "Daily Summary")
                            ExtraInfoTextBox(text: dailySummary)
                            NormalText(text: "About Visibility")
                                .padding(.top)
                            ExtraInfoTextBox(text: AboutConstants.visibility.rawValue)
                            
                            
                        }
                        .foregroundColor(.white)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ExtraInfoHeader(systemImage: "eye.fill", title: "Visibility")
                }
                ToolbarItem(placement: .primaryAction) {
                    Button{
                        isVisibilityShowing = false
                    } label: {
                        XMarkButton()
                    }
                }
            }
        }
    }
}

struct VisibilityExtraInfo_Previews: PreviewProvider {
    static private var isVisibilityShowing = Binding.constant(false)
    static var previews: some View {
        VisibilityExtraInfo(isVisibilityShowing: isVisibilityShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Today, the visibility will be perfectly clear, at 26 to 26km", visibility: "0km")
    }
}
