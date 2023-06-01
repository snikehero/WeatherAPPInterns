//
//  ExtraInfoView.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 22/05/23.
//

import SwiftUI



struct PrecipitationExtraInfo: View {
    @Binding var isShowing : Bool
    @Binding var forecasts: [ForecastViewModel]
    @Binding var dailyForecasts: [DailyForecastViewModel]
    @Binding var selectedSheet: showingSheets
    
    @State private var selectedTab = 0
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
                                            Text(dailyForecasts[element].exactDayName )
                                                .fontWeight(.semibold)
                                            Button(action: {
                                                selectedTab = element // Cambiar a la pestaña 0
                                            }) {
                                                if selectedTab == element {
                                                    SelectedRoundedFill(text: String(dailyForecasts[element].dayNumber ))
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
                                    ButtonTitle(text: dailyForecasts[selectedTab].pop )
                                    ButtonSubtitle(text: "In last 24h")
                                }
                                Spacer()
                                ExtraInfoScreenPicker(selectedInfo: $selectedSheet)
                            }.padding(.leading)
                            
                            
                            TabView(selection: $selectedTab) {
                                ForEach(0..<11){ i in
                                    PrecipitationChartMock()
                                        .tabItem {
                                            EmptyView()
                                        }
                                        .tag(i)
                                }
                            }
                            .frame(width: 300, height: 300)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                            ExtraInfoSection(header: "Daily Summary", text: "There has been \(dailyForecasts[selectedTab].pop ) of precipitation in the last 24 hours. Today's precipitation will be \(dailyForecasts[selectedTab].pop )")
                        }
                        .foregroundColor(.white)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // try with a switch statement
                // state variable with name
                ToolbarItem(placement: .principal) {
                    ExtraInfoHeader(systemImage: "drop.fill", title: "Precipitation")
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

struct ExtraInfoView_Previews: PreviewProvider {
    static private var isShowing = Binding.constant(false)
    //@Binding var forecasts = [ForecastViewModel.mock]
    //@Binding var dailyForecasts = [DailyForecastViewModel.mock]
    static var previews: some View {
        //PrecipitationExtraInfo(isShowing: isShowing, forecasts: forecasts, dailyForecasts: dailyForecasts)
        Text("Test")
    }
}
