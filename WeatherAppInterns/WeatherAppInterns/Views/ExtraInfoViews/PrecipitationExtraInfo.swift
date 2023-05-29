//
//  ExtraInfoView.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 22/05/23.
//

import SwiftUI
import Charts

enum ExtraInfo: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case Temperature, UVIndex = "UV Index", Wind, Precipitation, feelsLike = "Feels Like", Humidity, Visibility, Pressure
}

struct ExtraInfoSection: View {
    var header: String
    var text: String
    
    var body: some View {
        VStack {
            NormalText(text: header)
                .padding(.top)
            ExtraInfoTextBox(text: text)
        }
    }
}

//################## TEST DATA ##########################
struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

struct ChartMock: View {
    var data: [ToyShape] = [
        .init(type: "Cube", count: 5),
        .init(type: "Sphere", count: 4),
        .init(type: "Pyramid", count: 4)
    ]
    
    var body: some View{
        Chart{
            ForEach(data) { shape in
                LineMark(
                    x: .value("Shape Type", shape.type),
                    y: .value("Total Count", shape.count)
                ).lineStyle(StrokeStyle(lineWidth: 5))
            }
        }.padding()
    }
}
//################## TEST DATA ##########################



struct PrecipitationExtraInfo: View {
    @Binding var isShowing : Bool
    
    @State private var selectedTab = 0
    
    var currentDay: String
    var numberDay: Int
    var date: Date
    var dailySummary: String
    var precipitation: String
    
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
                                    ButtonTitle(text: precipitation)
                                    ButtonSubtitle(text: "In last 24h")
                                }
                                Spacer()
                                ExtraInfoScreenPicker(selectedInfo: "Precipitation")
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
    
    
    
    static var previews: some View {
        PrecipitationExtraInfo(isShowing: isShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "There has been 0 mm of precipitation in the last 24 hours. Today's total precipitation will be 0 mm", precipitation: "0mm")
    }
}



struct ExtraInfoScreenPicker: View {
    @State var selectedInfo: String
    var body: some View {
        Picker("Picker", selection: $selectedInfo) {
            ForEach(ExtraInfo.allCases){e in
                Text("\(e.rawValue)").tag(e.rawValue)
            }
        }.foregroundColor(.white)
    }
}
