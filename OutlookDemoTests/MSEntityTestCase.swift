//
//  MSEntityTestCase.swift
//  OutlookDemoTests
//
//  Created by Subhodip Banerjee on 09/04/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import XCTest
@testable import OutlookDemo

extension OutlookDemoTests{
    
    func testInitialMonthsSetUpWithConfig() {
        let currentCalendar = Calendar.current
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy MM dd"
        dateformatter.timeZone = currentCalendar.timeZone
        dateformatter.locale = currentCalendar.locale
        guard let fromDate = dateformatter.date(from: "2018 02 01") else {
            return
        }
        guard let toDate = dateformatter.date(from: "2018 03 01") else {
            return
        }
        guard let endDate = dateformatter.date(from: "2018 02 28") else {
            return
        }
        let config = ConfigureCalendar(startDate: fromDate, endDate: toDate, calendar: currentCalendar)
        let functionOutput = MonthConfiguration().setUpMonth(withParams: config)
        let givenOutput = [CalendarDatabaseConfiguration.Month(numberOfDaysInAMonth: 28, nameOfMonths: .Feb, startDate: fromDate, endDate: endDate, preDatesForMonth: 4, postDatesForMonth: 3)]
        XCTAssertEqual(givenOutput, functionOutput)
    }
    
    func testCreateMonth() {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = calendar.timeZone
        formatter.locale = calendar.locale
        guard let date = formatter.date(from: "2018 01 01") else { return }
        let monthIndex = 1
        let functionOutput = MonthConfiguration().createMonth(withCalendar: calendar, startDate: date, monthIndex: monthIndex)
        XCTAssertNotNil(functionOutput)
        
        guard let startDate = formatter.date(from: "2018 02 01") else { return }
        guard let endDate = formatter.date(from: "2018 02 28") else { return }
        let givenOutput = CalendarDatabaseConfiguration.Month(numberOfDaysInAMonth: 28, nameOfMonths: .Feb, startDate: startDate, endDate: endDate, preDatesForMonth: 4, postDatesForMonth: 3)
        XCTAssertEqual(givenOutput, functionOutput)
    }
}

extension CalendarDatabaseConfiguration.Month: Equatable {
    public static func == (lhs: CalendarDatabaseConfiguration.Month, rhs: CalendarDatabaseConfiguration.Month) -> Bool {
        if lhs.numberOfDaysInAMonth != rhs.numberOfDaysInAMonth || lhs.nameOfMonths != rhs.nameOfMonths ||
            lhs.preDatesForMonth != rhs.preDatesForMonth || lhs.postDatesForMonth != rhs.postDatesForMonth ||
            lhs.startDate.compare(rhs.startDate) != ComparisonResult.orderedSame ||
            lhs.endDate.compare(rhs.endDate) != ComparisonResult.orderedSame {
            return false
        }
        return true
    }
}

