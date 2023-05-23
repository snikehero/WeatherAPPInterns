//
//  DetailsView.swift
//  WeatherAppInterns
//
//  Created by Leo Avalos on 22/05/23.
//

import SwiftUI

struct DetailsView: View {
    var body: some View {
        VStack{
            TopView(unit: "Temperature", currentDay: "M", numberDay: 26, date: Date())
            
            
        }
    }
}

struct TopView: View {
    @State private var selectedTab = 0
    var unit: String
    var currentDay: String
    var numberDay: Int
    var date: Date
    var body: some View{
        
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    
                    
                    Label(unit , systemImage: "thermometer.medium" )
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        // Acción del botón
                    }) {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .accentColor(.gray)
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal)
            }
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(0..<10) { element in
                            VStack(spacing : 1){
                                Text(currentDay)
                                Button(action: {
                                    selectedTab = element // Cambiar a la pestaña 0
                                }) {
                                    Text(String(numberDay))
                                        .font(.headline)
                                        .foregroundColor(selectedTab == element ? .blue : .gray)
                                        .padding()
                                }
                            }
                        }
                        
                    }
                }
                
                Text(Date(), style: .date)
                
                TabView(selection: $selectedTab) {
                    Text("Contenido de la vista 1")
                        .tabItem {
                            EmptyView()
                        }
                        .tag(0)
                    
                    Text("Contenido de la vista 2")
                        .tabItem {
                            EmptyView()
                        }
                        .tag(1)
                    
                    Text("Contenido de la vista 3")
                        .tabItem {
                            EmptyView()
                        }
                        .tag(2)
                    
                    Text("Contenido de la vista 4")
                        .tabItem {
                            EmptyView()
                        }
                        .tag(3)
                    
                    Text("Contenido de la vista 5")
                        .tabItem {
                            EmptyView()
                        }
                        .tag(4)
                    
                    Text("Contenido de la vista 6")
                        .tabItem {
                            EmptyView()
                        }
                        .tag(5)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            
        }
    }
}




struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
        
    }
}

