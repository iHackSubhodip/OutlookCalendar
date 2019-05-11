//
//  MSAPIError.swift
//  OutlookDemo
//
//  Created by Banerjee, Subhodip on 27/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import Foundation

/**
 This enum(value type) -> `MSAPIError` contains the following API error response:
 - Request Failed.
 - Invalid Data.
 - Response Unsuccessful.
 - JSON Parsing Failure.
 - JSON Conversion Failure.
 */
enum MSAPIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}
