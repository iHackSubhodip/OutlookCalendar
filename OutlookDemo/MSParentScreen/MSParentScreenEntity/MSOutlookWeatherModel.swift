//
//  MSOutlookWeatherModel.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 21/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 - This Entity contains all the models for `WeatherView`.
 */
import Foundation
/**
 `MSOutlookWeatherModelData` defines `Weather` model.
 - `weatherData: [Date: MSOutlookWeatherModelInfo]` - array of weather data.
 - `firstDate: Date` - start date to show weather data.
 - `lastDate: Date` - end date to show weather data.
 - `dataRetrived: Bool` - is Weather model updated.
 */
struct MSOutlookWeatherModelData{
    let weatherData: [Date: MSOutlookWeatherModelInfo]
    let firstDate: Date
    let lastDate: Date
    let dataRetrived: Bool
}
/**
 `MSOutlookWeatherModelInfo` defines weather data.
 - `summary: String` - summary of current date weather.
 - `icon: String` - icon of weather.
 */
struct MSOutlookWeatherModelInfo{
    let summary: String
    let icon: String
}
