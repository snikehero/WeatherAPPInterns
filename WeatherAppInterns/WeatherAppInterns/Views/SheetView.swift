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
//    @StateObject var forecastListVM: CityForecastModel
//    @StateObject var dailyForecastListVM: DailyForecastListViewmodel
//    @StateObject var airPollutionListVM: AirPollutionListViewModel
    @EnvironmentObject var forecastListVM: CityForecastModel
    @EnvironmentObject var dailyForecastListVM: DailyForecastListViewmodel
    @EnvironmentObject var airPollutionListVM: AirPollutionListViewModel
    var body: some View{
        switch selectedSheet {
        case .precipitation:
          //PrecipitationExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
          PrecipitationExtraInfo(isShowing: $isShowing, selectedSheet: $selectedSheet)
            .environmentObject(forecastListVM)
            .environmentObject(dailyForecastListVM)
        case .visibility:
          //VisibilityExtraInfo(isShowing: $isShowing,forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
          VisibilityExtraInfo(isShowing: $isShowing,selectedSheet: $selectedSheet)
            .environmentObject(forecastListVM)
            .environmentObject(dailyForecastListVM)
        case .wind:
          //WindExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
          WindExtraInfo(isShowing: $isShowing, selectedSheet: $selectedSheet)
            .environmentObject(forecastListVM)
            .environmentObject(dailyForecastListVM)
        case .uvIndex:
          //UvIndexExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
          UvIndexExtraInfo(isShowing: $isShowing, selectedSheet: $selectedSheet)
            .environmentObject(forecastListVM)
            .environmentObject(dailyForecastListVM)
        case .feelsLike:
          //FeelsLikeExtraInfo(isShowing: $isShowing,forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
          FeelsLikeExtraInfo(isShowing: $isShowing, selectedSheet: $selectedSheet)
            .environmentObject(forecastListVM)
            .environmentObject(dailyForecastListVM)
        case .humidity:
          //HumidityExtraInfo(isShowing: $isShowing, forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet)
          HumidityExtraInfo(isShowing: $isShowing, selectedSheet: $selectedSheet)
            .environmentObject(forecastListVM)
            .environmentObject(dailyForecastListVM)
        case .pressure:
          //PressureExtraInfo(isShowing: $isShowing,forecasts: $forecastListVM.forecasts, dailyForecasts: $dailyForecastListVM.dailyForecasts, selectedSheet: $selectedSheet )
          PressureExtraInfo(isShowing: $isShowing, selectedSheet: $selectedSheet )
            .environmentObject(forecastListVM)
            .environmentObject(dailyForecastListVM)
        case .airQuality:
          //AirQualityExtraInfo(isShowing: $isShowing, airQuality: $airPollutionListVM.airPollutions)
          AirQualityExtraInfo(isShowing: $isShowing)
            .environmentObject(airPollutionListVM)
        }
    }
}
