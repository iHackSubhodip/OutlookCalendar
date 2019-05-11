//
//  MSDateFormatterTestCase.swift
//  OutlookDemoTests
//
//  Created by Subhodip Banerjee on 09/04/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import XCTest
@testable import OutlookDemo

extension OutlookDemoTests{
    
    func testGetHoursMinutes() {
        let epoch = 1515636644.582459
        let input1 = MSAppUtility.epochToDate(epoch: epoch)
        let output1 = DateFormatter().getHoursMinutes(date: input1)
        XCTAssertEqual(output1, "12:00 AM")
    }
    func testGetDate() {
        let epochTime = 1515636644.582459
        let input1 = MSAppUtility.epochToDate(epoch: epochTime)
        let output1 = DateFormatter().getDate(date: input1)
        XCTAssertEqual(output1, "11")
    }
    func testGetMonth() {
        let epochTime = 1515636644.582459
        let input1 = MSAppUtility.epochToDate(epoch: epochTime)
        let output1 = DateFormatter().getMonth(date: input1)
        XCTAssertEqual(output1, "01")

    }
    func testGetFullDetails() {
        let epochTime = 1515636644.582459
        let input1 = MSAppUtility.epochToDate(epoch: epochTime)
        let output1 = DateFormatter().getFullDetails(for: input1)
        XCTAssertEqual(output1, "Thursday, 11 January 2018")
    }
    func testMonthDescription() {
        let epochTime = 1515636644.582459
        let input1 = MSAppUtility.epochToDate(epoch: epochTime)
        let output1 = DateFormatter().monthDescription(date: input1)
        XCTAssertEqual(output1, "January 2018")
    }
}
