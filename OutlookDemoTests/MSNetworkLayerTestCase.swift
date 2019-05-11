//
//  MSNetworkLayerTestCase.swift
//  OutlookDemoTests
//
//  Created by Subhodip Banerjee on 09/04/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import XCTest
@testable import OutlookDemo

extension OutlookDemoTests{
    func testfetchData(){
        let weatherManager = MSOutlookWeatherManager()
        let successUrl = "https://api.darksky.net/forecast/dd4e55ff06515b974993ce78b82b1695/12.923495,77.685107"
        weatherManager.getWeatherFeed(from: successUrl) { (result) in
            switch result {
            case .success(let weatherFeedResult):
                //print(weatherFeedResult)
                XCTAssertNotNil(weatherFeedResult)
            case .failure(let error):
                print(error.localizedDescription)
                XCTAssertNil(error)
            }
        }
    }
}
