//
//  SheetView.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 31/05/23.
//

import SwiftUI

struct SheetView: View{
    @Binding var isShowing: Bool
    @Binding var selectedSheet: showingSheets
    @StateObject var forecastListVM: ForecastListViewModel
    @StateObject var dailyForecastListVM: DailyForecastListViewmodel
    @StateObject var airPollutionListVM: AirPollutionListViewModel
    
    var body: some View{
        switch selectedSheet {
        case .precipitation:
          PrecipitationExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
        case .visibility:
          VisibilityExtraInfo(isShowing: $isShowing,forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
        case .wind:
          WindExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
        case .uvIndex:
          UvIndexExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
        case .feelsLike:
          FeelsLikeExtraInfo(isShowing: $isShowing,forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
        case .humidity:
          HumidityExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
        case .pressure:
          PressureExtraInfo(isShowing: $isShowing,forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet )
        case .airQuality:
          AirQualityExtraInfo(isShowing: $isShowing, airQuality: $airPollutionListVM.airPollutions)
        }
    }
}
