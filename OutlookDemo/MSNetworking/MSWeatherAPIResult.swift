//
//  MSWeatherAPIResult.swift
//  OutlookDemo
//
//  Created by Banerjee, Subhodip on 27/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import Foundation

/**
 This enum(value type) -> `MSWeatherAPIResult` contains the following API response:
 - Success Result from JSON API, <T> represents Generics type.
 - Failure Result from JSON API, <U> represents Error type.
 */
enum MSWeatherAPIResult<T, U> where U: Error{
    case success(T)
    case failure(U)
}
