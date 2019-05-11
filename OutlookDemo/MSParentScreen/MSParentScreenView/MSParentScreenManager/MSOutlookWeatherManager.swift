//
//  MSOutlookWeatherManager.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 21/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 `MSOutlookWeatherManager` is a data manager class for `WeatherView` elements, which contains the logic for parsing weather JSON Object. This class updates `MSOutlookWeatherModelData` model objects.

 */
import UIKit
import CoreLocation

final class MSOutlookWeatherManager{
    // MARK: - instance properties
    var weatherModel: MSOutlookWeatherModelData?
    weak var weatherDelegate: WeatherManagerOutputProtocol?
    
    /**
     This function `fetchWeatherInformation()` decodes and updates `MSOutlookWeatherModelData` model objects. It's called from `MSParentScreenViewController`'s `viewDidAppear`.
     - locationCoordinate: it holds current locations `latitude` & `longitude`.
     - weatherUrl: Creates `weatherUrl` with current `locationCoordinate`.
     - Inside `getWeatherFeed` method called,On completion it returns JSON object with `MSWeatherAPIResult` [success or failure].
     - On success, it calles the `didFetchWeatherDetailSuccess()` method in `WeatherManagerOutputProtocol` protocol with the help of weatherDelegate delegate.
     - On failure, it calles the `didFetchWeatherDetailFailure()` method in `WeatherManagerOutputProtocol` protocol with the help of weatherDelegate delegate.
     - returns: updates `EveryDayAgendaEvents` model objects.
     */
    func fetchWeatherInformation(location: CLLocationCoordinate2D){
        let locationCoordinate = "\(location.latitude)" + "," + "\(location.longitude)"
        let weatherUrl = MSOutlookConstants.MSWeather.weatherAPI + locationCoordinate
        
        getWeatherFeed(from: weatherUrl) { [weak self] result in
            
            guard let selfObject = self else{
                return
            }
            switch result {
            case .success(let weatherFeedResult):
                guard let weatherDictionary = weatherFeedResult as? [String: Any], let dailyWeather = weatherDictionary[MSOutlookConstants.MSWeather.daily] as? [String: Any], let dailyWeatherData = dailyWeather[MSOutlookConstants.MSWeather.data] as? [[String: Any]] else{
                    return
                }
                var weatherInformation: [Date: MSOutlookWeatherModelInfo] = [:]
                var firstDate: Date?
                var lastDate: Date?
                guard let first = dailyWeatherData.first?[MSOutlookConstants.MSWeather.time] as? TimeInterval, let last = dailyWeatherData.last?[MSOutlookConstants.MSWeather.time] as? TimeInterval else{
                    return
                }
                firstDate = MSAppUtility.epochToDate(epoch: first)
                lastDate = MSAppUtility.epochToDate(epoch: last)
                
                for eachWeatherData in dailyWeatherData{
                    if let time = eachWeatherData[MSOutlookConstants.MSWeather.time] as? TimeInterval, let icon = eachWeatherData[MSOutlookConstants.MSWeather.icon] as? String, let summary = eachWeatherData[MSOutlookConstants.MSWeather.summary] as? String{
                        let date = MSAppUtility.epochToDate(epoch: time)
                        let weatherData = MSOutlookWeatherModelInfo(summary: summary, icon: icon)
                        weatherInformation[date] = weatherData
                    }
                }
                if let firstDate = firstDate, let lastDate = lastDate, !weatherInformation.isEmpty {
                    let weatherModelData = MSOutlookWeatherModelData(weatherData: weatherInformation, firstDate: firstDate, lastDate: lastDate, dataRetrived: true)
                    selfObject.weatherModel = weatherModelData
                }
                selfObject.weatherDelegate?.didFetchWeatherDetailSuccess()
            case .failure(let error):
                print("the error \(error)")
                let weatherModelData = MSOutlookWeatherModelData(weatherData: [:], firstDate: Date(), lastDate: Date(), dataRetrived: false)
                selfObject.weatherModel = weatherModelData
                selfObject.weatherDelegate?.didFetchWeatherDetailFailure()
            }
        }
    }
}

extension MSOutlookWeatherManager{
    /**
     This function `getWeatherFeed()` calls `MSNetworkingClass.fetchData`, which is a GET request.
     - url: it holds the url needs to be called .
     - completion: holds` MSWeatherAPIResult<Any, MSAPIError>`, taking JSON object as Any and error as `MSAPIError`.
     - returns: on completion, it executes MSWeatherAPIResult [success/failure].
     */
    func getWeatherFeed(from url: String, completion: @escaping (MSWeatherAPIResult<Any, MSAPIError>) -> Void) {
        MSNetworkingClass.fetchData(with: url, completion: completion)
    }
}
