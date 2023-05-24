//
//  ExtraInfoView.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 22/05/23.
//

import SwiftUI
import Charts

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

struct SelectedRoundedFill: View {
    var text: String
    var body: some View{
        Text(text)
            .fontWeight(.semibold)
            .padding()
            .foregroundColor(Color("ExtraInfoBackgroundColor"))
            
            .background(
                Circle()
                    .fill(.white)
                    .frame(maxWidth: 30, maxHeight: 30)
                )
    }
}

struct PrecipitationExtraInfo: View {
    @Binding var isPrecipitationShowing : Bool
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
                            }.padding(.leading)
                            
                           
                            TabView(selection: $selectedTab) {
                                ForEach(0..<11){ i in
                                    ChartMock()
                                        .tabItem {
                                            EmptyView()
                                        }
                                        .tag(i)
                                }
                                //                                Text("PRUEBA")
                                //                                    .tabItem {
                                //                                        EmptyView()
                                //                                    }
                                //                                    .tag(0)
                                //
                                //                                Text("Contenido de la vista 2")
                                //                                    .tabItem {
                                //                                        EmptyView()
                                //                                    }
                                //                                    .tag(1)
                                //
                                //                                Text("Contenido de la vista 3")
                                //                                    .tabItem {
                                //                                        EmptyView()
                                //                                    }
                                //                                    .tag(2)
                                //
                                //                               Text("Contenido de la vista 4")
                                //                                   .tabItem {
                                //                                       EmptyView()
                                //                                   }
                                //                                   .tag(3)
                                //
                                //                               Text("Contenido de la vista 5")
                                //                                   .tabItem {
                                //                                       EmptyView()
                                //                                   }
                                //                                   .tag(4)
                                //
                                //                               Text("Contenido de la vista 6")
                                //                                   .tabItem {
                                //                                       EmptyView()
                                //                                   }
                                //                                   .tag(5)
                            }
                            .frame(width: 300, height: 300)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                            NormalText(text: "Daily Summary")
                            ExtraInfoTextBox(text: dailySummary)
                            
                            
                        }
                        .foregroundColor(.white)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ExtraInfoHeader(systemImage: "drop.fill", title: "Precipitation")
                }
                ToolbarItem(placement: .primaryAction) {
                    Button{
                        isPrecipitationShowing = false
                    } label: {
                        XMarkButton()
                    }
                }
            }
        }
    }
}

struct ExtraInfoView_Previews: PreviewProvider {
    static private var isPrecipitationShowing = Binding.constant(false)
    
    static var previews: some View {
        PrecipitationExtraInfo(isPrecipitationShowing: isPrecipitationShowing, currentDay: "M", numberDay: 26, date: Date(), dailySummary: "There has been 0 mm of precipitation in the last 24 hours. Today's total precipitation will be 0 mm", precipitation: "0mm")
    }
}


