//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by Ulises Burns on 24/05/23.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetLiveActivity()
    }
}
