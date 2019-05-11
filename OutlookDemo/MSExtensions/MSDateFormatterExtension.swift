//
//  MSDateFormatterExtension.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 01/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

/**
 This class(reference type) extension -> `DateFormatter` contains all the methods, which are required to convert `Date` to required `String` format.
 */

import Foundation

extension DateFormatter {
    /**
     This function `getHoursMinutes` converts `date`[`Date`] to `hh:mm a`[`String`] value.
     - parameter date: We are passing `date`[`Date`].
     - returns: It will return `Hours Minutes` in String format.
     - warning: It will return blank string, if there is no valid `date`.
     */
    public func getHoursMinutes(date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        dateFormat = "hh:mm a"
        return string(from: date)
    }
    /**
     This function `getDate` converts `date`[`Date`] to `dd`[`String`] value.
     - parameter date: We are passing `date`[`Date`].
     - returns: It will return particular given `Date` in String format.
     - warning: It will return blank string, if there is no valid `date`.
     */
    public func getDate(date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        dateFormat = "dd"
        return string(from: date)
    }
    /**
     This function `getMonth` converts `date`[`Date`] to `MM`[`String`] value.
     - parameter date: We are passing `date`[`Date`].
     - returns: It will return particular given `MM` in String format.
     - warning: It will return blank string, if there is no valid `date`.
     */
    public func getMonth(date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        dateFormat = "MM"
        return string(from: date)
    }
    /**
     This function `getFullDetails` converts `date`[`Date`] to `EEEE, dd MMMM yyyy`[`String`] value.
     - parameter date: We are passing `date`[`Date`].
     - returns: It will return particular given `fullDateDetails` in String format ["EEEE, dd MMMM yyyy"].
     - warning: It will return blank string, if there is no valid `date`.
     */
    public func getFullDetails(for date: Date?) -> String { 
        guard let date = date else {
            return ""
        }
        dateFormat = "EEEE, dd MMMM yyyy"
        return string(from: date)
    }
    
    /**
     This class function `monthDescription` converts `date`[`Date`] to `MMMM yyyy`[`String`] value.
     - parameter date: We are passing `date`[`Date`].
     - returns: It will return particular given `Month Description` in String format.
     - warning: It will return blank string, if there is no valid `date`.
     */
    public func monthDescription(date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        dateFormat = "MMMM yyyy"
        return string(from: date)
    }
    
    /**
     This class function `convertEpochToDate` converts `epoch`[`Date`] to particular timezone value.
     - parameter date: We are passing `date`[`Date`].
     - returns: It will return `Date` in Date format.
     */
    
    public func convertEpochToDate(date: Date?) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 19800)
        guard let date = date else{
            return Date()
        }
        let stringDate = dateFormatter.string(from: date)
        let desiredDate = dateFormatter.date(from: stringDate)
        return desiredDate!
    }
}
