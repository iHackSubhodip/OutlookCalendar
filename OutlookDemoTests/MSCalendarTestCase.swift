//
//  MSCalendarTestCase.swift
//  OutlookDemoTests
//
//  Created by Subhodip Banerjee on 09/04/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import XCTest
@testable import OutlookDemo

extension OutlookDemoTests{

    func testStartOfMonth() {
        let calendar = Calendar.current
        let epoch = 1515636644.582459 // epoch time
        let input = MSAppUtility.epochToDate(epoch: epoch)
        let functionOutput = calendar.startOfMonth(forThe: input)
        XCTAssertNotNil(functionOutput)
        let outputString = DateFormatter().getFullDetails(for: functionOutput)
        XCTAssertEqual(outputString, "Monday, 01 January 2018")
    }
    func testEndOfMonth() {
        let calendar = Calendar.current
        let epoch = 1515636644.582459 // epoch time
        let input = MSAppUtility.epochToDate(epoch: epoch)
        let functionOutput = calendar.endOfMonth(forThe: input)
        XCTAssertNotNil(functionOutput)
        let outputString = DateFormatter().getFullDetails(for: functionOutput)
        XCTAssertEqual(outputString, "Wednesday, 31 January 2018")
    }
    
    func testNumberOfWeeksPerMonth() {
        let calendar = Calendar.current
        let epoch = 1515636644.582459 // epoch time
        let input = MSAppUtility.epochToDate(epoch: epoch)
        let functionOutput = calendar.numberOfWeeksPerMonth(forThe: input)
        XCTAssertEqual(functionOutput, 5)
    }
}
