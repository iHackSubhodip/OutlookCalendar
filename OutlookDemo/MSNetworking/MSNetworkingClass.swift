//
//  MSNetworkingClass.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

/**
 This Networking class MSNetworkingClass supports networking using `URl`, `URLSession`, `URLSessionDataTask`, `HTTPURLResponse`, `JSONSerialization`. It supports:
 - GET Request
 - decodingTask -> URLSessionDataTask
 */
import Foundation

typealias JSONTaskCompletionHandler = (Any?, MSAPIError?) -> Void

final class MSNetworkingClass{
    /**
     This function `decodingTask` returns the downloaded data directly to application using `URLSessionDataTask`.
     - parameter request: We are passing `request`[`URL`] in URL format from the method `fetchData`.
     - parameter completion: There is an escaping argument, because when `decodingTask` function ends, the scope of the passed closure exist and have existence in memory, till the closure gets executed. the completion is a `typealias` which consists of `(Any?, MSAPIError?)` and reutns `Void`.
     - returns: It will return the downloaded data directly to application using `URLSessionDataTask`.
     - warning: If it doesn't return `JSON` data, then `MSAPIError` occurs.
     */
    class func decodingTask(with request: URL, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    guard let response = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return }
                    completion(response, nil)
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        
        return task
    }
    /**
     This function `fetchData` is a `GET` request. It executes success & failure for `MSWeatherAPIResult`.
     - parameter request: We are passing `urlString`[`String`] in String format.
     - parameter completion: There is an escaping argument, because when `fetchData` function ends, the scope of the passed closure exists and have existence in memory, till the closure gets executed. The completion block contains `MSWeatherAPIResult<Any, MSAPIError>`.
     */
    class func fetchData(with urlString: String, completion: @escaping (MSWeatherAPIResult<Any, MSAPIError>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = decodingTask(with: url) { (json , error) in
            
            if let json = json{
                completion(MSWeatherAPIResult.success(json))
            } else {
                if let error = error {
                    completion(MSWeatherAPIResult.failure(error))
                } else {
                    completion(MSWeatherAPIResult.failure(.invalidData))
                }
                return
            }
        }
        task.resume()
    }
    
}
