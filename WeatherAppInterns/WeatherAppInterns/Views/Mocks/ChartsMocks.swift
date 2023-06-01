//
//  ChartsMocks.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 01/06/23.
//

import Foundation
import SwiftUI
import Charts

struct PressureChartMock: View {
    var data: [Registry] = [
        Registry(hour: 0, value: 1006),
        Registry(hour: 6, value: 1010),
        Registry(hour: 12, value: 1003),
        Registry(hour: 18, value: 1005),
        Registry(hour: 24, value: 1010),
    ]
    
    var body: some View{
        Chart (data){ registry in
            AreaMark(
                x: .value("Hour", registry.hour),
                y: .value("Pressure", registry.value)
            )
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 5))
            .foregroundStyle(Color.purple)
            
        }
        .padding()
    }
}

struct UVIndexChartMock: View {
    var data: [Registry] = [
        Registry(hour: 0, value: 0),
        Registry(hour: 6, value: 0),
        Registry(hour: 12, value: 14),
        Registry(hour: 18, value: 0),
        Registry(hour: 24, value: 0),
    ]
    
    var body: some View{
        Chart (data){ registry in
            AreaMark(
                x: .value("Hour", registry.hour),
                y: .value("UV Index", registry.value)
            )
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 5))
            .foregroundStyle(Gradient(colors: [.purple,.red,.orange,.yellow,.green]))
            
        }
        .padding()
    }
}

struct VisibilityChartMock: View {
    var data: [Registry] = [
        Registry(hour: 0, value: 25),
        Registry(hour: 6, value: 24),
        Registry(hour: 12, value: 26),
        Registry(hour: 18, value: 26),
        Registry(hour: 24, value: 25),
    ]
    
    var body: some View{
        Chart (data){ registry in
            AreaMark(
                x: .value("Hour", registry.hour),
                y: .value("Visibility", registry.value)
            )
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 5))
            .foregroundStyle(Gradient(colors: [.white,.gray]))
            
        }
        .padding()
    }
}

struct PrecipitationChartMock: View {
    var data: [Registry] = [
        Registry(hour: 0, value: 0),
        Registry(hour: 6, value: 0),
        Registry(hour: 12, value: 0),
        Registry(hour: 17, value: 1),
        Registry(hour: 18, value: 1),
        Registry(hour: 19, value: 1),
        Registry(hour: 24, value: 0),
    ]
    
    var body: some View{
        Chart (data){ registry in
            BarMark(
                x: .value("Hour", registry.hour),
                y: .value("Precipitation", registry.value)
            )
            .lineStyle(StrokeStyle(lineWidth: 5))
            .foregroundStyle(Color.blue)
            
        }
        .padding()
    }
}

struct FeelsLikeChartMock: View {
    var data: [Registry] = [
        Registry(hour: 0, value: 21),
        Registry(hour: 6, value: 18),
        Registry(hour: 12, value: 30),
        Registry(hour: 16, value: 33),
        Registry(hour: 18, value: 30),
        Registry(hour: 24, value: 21),
    ]
    
    var body: some View{
        Chart (data){ registry in
            AreaMark(
                x: .value("Hour", registry.hour),
                y: .value("Temperature", registry.value)
            )
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 5))
            .foregroundStyle(Gradient(colors: [.red,.yellow,.blue,]))
            
        }
        .padding()
    }
}
