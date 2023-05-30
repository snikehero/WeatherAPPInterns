//
//  visibilityExtraInfo.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import SwiftUI
import Charts

struct VisibilityExtraInfo: View {
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
                  ButtonTitle(text: forecasts.first?.visibility ?? "visibility")
                  ButtonSubtitle(text: forecasts.first?.visibilityDescription ?? "visibility description")
                }
                Spacer()
                ExtraInfoScreenPicker(selectedInfo: "Visibility")
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
              
              ExtraInfoSection(header: "Daily Summary", text: "Today the visibility will be: \(forecasts.first?.visibility ?? "0") to \(forecasts.first?.visibility ?? "0")")
              ExtraInfoSection(header: "About Visibility", text: AboutConstants.visibility.rawValue)
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
            isShowing.toggle()
          } label: {
            XMarkButton()
          }
        }
      }
    }
  }
}

struct VisibilityExtraInfo_Previews: PreviewProvider {
  static private var isShowing = Binding.constant(false)
  static var previews: some View {
    //VisibilityExtraInfo(isShowing: isShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "Today, the visibility will be perfectly clear, at 26 to 26km", visibility: "0km")
    Text("prueba")
  }
}
