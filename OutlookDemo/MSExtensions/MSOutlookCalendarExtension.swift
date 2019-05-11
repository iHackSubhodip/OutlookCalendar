//
//  MSOutlookCalendarExtension.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 22/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

/**
 This class(reference type) extension -> `Calendar` contains all the methods, which are required to find the following:
 - Start of a Month
 - End of a Month
 - Number of weeks in a Month.
 */
import Foundation

extension Calendar{
    
    // MARK: - DateFormatter
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        dateFormatter.isLenient = true
        return dateFormatter
    }()
    /**
     This function `dateFormatterComponents` converts `date`[`Date`] to (`month`, `year`) in Optional tuple format.
     - This is the helper function to `startOfMonth`, `endOfMonth`.
     - parameter date: We are passing `date`[`Date`].
     - returns: It will return (`month`, `year`) in Optional tuple format.
     - warning: It will return nil, if there is no valid (`month`, `year`).
     */
    private func dateFormatterComponents(fromDate date: Date) -> (month: Int, year: Int)?{
        Calendar.dateFormatter.timeZone = timeZone
        Calendar.dateFormatter.locale = locale
        Calendar.dateFormatter.calendar = self
        
        let component = dateComponents([.year, .month], from: date)
        guard let month = component.month, let year = component.year else {
            return nil
        }
        return (month, year)
    }
    /**
     This function `startOfMonth` converts `date`[`Date`] to start of the month in Optional `Date` format.
     - parameter date: We are passing `date`[`Date`].
     - returns: It will return start of the months in Optional `Date` format.
     - warning: It will return nil, if there is no valid `dateFormatterComponents`.
     */
    func startOfMonth(forThe date: Date) -> Date?{
        guard let component = dateFormatterComponents(fromDate: date) else {
            return nil
        }
        return Calendar.dateFormatter.date(from: "01 \(component.month) \(component.year)")
    }
    /**
     This function `endOfMonth` converts `date`[`Date`] to end of the month in Optional `Date` format.
     - parameter date: We are passing `date`[`Date`].
     - returns: It will return end of the month in Optional `Date` format.
     - warning: It will return nil, if there is no valid `dateFormatterComponents`.
     */
    func endOfMonth(forThe date: Date) -> Date?{
        guard let component = dateFormatterComponents(fromDate: date),
            let day = range(of: .day, in: .month, for: date)?.count,
            let endOfMonthDayValue = Calendar.dateFormatter.date(from: "\(day) \(component.month) \(component.year)") else {
                return nil
        }
        return endOfMonthDayValue
    }
    /**
     This function `endOfMonth` converts `date`[`Date`] to number of weeks in a month in `Int` format.
     - parameter date: We are passing `date`[`Date`].
     - returns: It will return number of weeks in a month in `Int` format.
     - warning: It will return 6, if there is no valid `endOfMonth`.
     */
    func numberOfWeeksPerMonth(forThe date: Date) -> Int {
        guard let endOfMonth = endOfMonth(forThe: date) else {
            return 6
        }
        return component(.weekOfMonth, from: endOfMonth)
    }
    
}
