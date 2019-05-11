//
//  MSDataManagerTestCase.swift
//  OutlookDemoTests
//
//  Created by Subhodip Banerjee on 09/04/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import XCTest
@testable import OutlookDemo

extension OutlookDemoTests{
    func testInitializeCalendar() {
        let dataSource = MSOutlookCalendarManager()
        try? dataSource.initCalendar()
        
        XCTAssertNotNil(dataSource.calendarDatabase)
        let calendarDatabase = dataSource.calendarDatabase
        
        let startDate = calendarDatabase?.startDateUpperRange // check start date
        XCTAssertNotNil(startDate)
        let detailsOfStartDate = DateFormatter().getFullDetails(for: startDate!)
        XCTAssertEqual(detailsOfStartDate, "Thursday, 01 March 2018") //it may change as it depends on the current date.
        
        let endDate = calendarDatabase?.endDateLowerRange // check end date
        XCTAssertNotNil(endDate)
        let detailsOfEndDate = DateFormatter().getFullDetails(for: endDate!)
        XCTAssertEqual(detailsOfEndDate, "Monday, 01 April 2019")//it may change as it depends on the current date.
        
        let monthsCount = calendarDatabase?.month.count ?? 0
        XCTAssertEqual(monthsCount, 13) // Loading 13 months in one shot.
    }
}
