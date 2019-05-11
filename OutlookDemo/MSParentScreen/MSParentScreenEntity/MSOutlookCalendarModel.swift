//
//  MSOutlookCalendarModel.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 `MSOutlookCalendarModel` which contains the entities, which are the basic model objects used by the Interactor.
 - This Entity contains all the models for `CalendarView`.
 */
import Foundation

/**
 `CalendarDatabaseConfiguration` is the main backbone for making the `Calendar`.
 • `Month`:-
 -  `numberOfDaysInAMonth: Int` - for number of days in a month.
 -  `nameOfMonths: MonthsInAYear` - name of the months , e.g. Jan, Feb.
 -  `startDate: Date` - start date of the month.
 -  `endDate: Date` - end date of the month.
 -  `preDatesForMonth: Int` - preoffsets for each month, e.g. - For March 2018 preoffsets are 4. as 25,26,27,28th Feb is present before 1st April 2018.
 -  `postDatesForMonth: Int` - preoffsets for each month, similar to preoffset it's number of postoffset dates after Month end.
 • `CalendarDatabase`:-
 -  `startDateUpperRange: Date` - start date of the calendar.
 -  `endDateLowerRange: Date` - end date of the calendar.
 -  `month: [Month]` - Array of Month Structure.
 -  `todaysCalendarDate: Int` - Todays date.
 -  `totalCalendarCellsInCollectionView: Int` - Number of collectionview cells to be made for startDateUpperRange and endDateLowerRange.
 -  `agenda:[AgendaDatabaseConfig.EveryDayAgenda]` - agenda of each date.
 */
struct CalendarDatabaseConfiguration{
    
    struct Month{
        let numberOfDaysInAMonth: Int
        let nameOfMonths: MonthsInAYear
        let startDate: Date
        let endDate: Date
        let preDatesForMonth: Int
        let postDatesForMonth: Int
    }
    
    struct CalendarDatabase{
        var startDateUpperRange: Date
        var endDateLowerRange: Date
        var month: [Month]
        var todaysCalendarDate: Int
        var totalCalendarCellsInCollectionView: Int
        var agenda:[AgendaDatabaseConfig.EveryDayAgenda]
    }
    
}
/**
 `ConfigureCalendar` defines `Calendar` configuration.
 - `startDate: Date` - start date of the calendar.
 - `endDate: Date` - end date of the calendar.
 - `calendar: Calendar` - init Calendar.
 */
struct ConfigureCalendar{
    let startDate: Date
    let endDate: Date
    let calendar: Calendar
    
    init(startDate: Date, endDate: Date, calendar: Calendar? = nil){
        self.startDate = startDate
        self.endDate = endDate
        self.calendar = calendar ?? Calendar.current
    }
}
 /**
 This `MonthConfiguration` structure configure the months for the `Calendar`.
 */
struct MonthConfiguration{
    
    /**
     This function `preDatesForTheMonth` gets the preoffsets for each month.
     - parameter date: We are passing `date`[`Date`] in Date format.
     - parameter calendar: We are passing `calendar`[`Calendar`] in Calendar format.
     - returns: It will return preoffsets for each month in `Int` format.
     */
    private func preDatesForTheMonth( date: Date, calendar: Calendar) -> Int{
        let firstWeekdayOfMoth = calendar.component(.weekday, from: date)
        return firstWeekdayOfMoth == 0 ? 0 : firstWeekdayOfMoth - 1
    }
    /**
     This function `createMonth` updates the model for `CalendarDatabaseConfiguration.Month` and create a Month.
     - parameter withCalendar: We are passing `withCalendar`[`Calendar`] in Calendar format.
     - parameter startDate: We are passing `startDate`[`Date`] in Date format.
     - parameter monthIndex: We are passing `monthIndex`[`Int`] in Int format for the particular month.
     - returns: It will return the model for `CalendarDatabaseConfiguration.Month and create a month.
     */
    func createMonth(withCalendar: Calendar, startDate: Date, monthIndex: Int) -> CalendarDatabaseConfiguration.Month?{
        guard let monthDate = withCalendar.date(byAdding: .month, value: monthIndex, to: startDate), let startDate = withCalendar.startOfMonth(forThe: monthDate), let endDate = withCalendar.endOfMonth(forThe: monthDate) else {
            return nil
        }
        let allMonths = [MonthsInAYear.Jan, MonthsInAYear.Feb, MonthsInAYear.Mar, MonthsInAYear.Apr, MonthsInAYear.May, MonthsInAYear.Jun, MonthsInAYear.Jul, MonthsInAYear.Aug, MonthsInAYear.Sep, MonthsInAYear.Oct, MonthsInAYear.Nov, MonthsInAYear.Dec]
        let eachMonthIndexName = withCalendar.component(.month, from: monthDate) - 1
        let countNumberOfDays = withCalendar.range(of: .day, in: .month, for: monthDate)?.count ?? 0
        let numberOfPreviousOffsetDates = preDatesForTheMonth(date: monthDate, calendar: withCalendar)
        let numberOfWeeksPerMonth = withCalendar.numberOfWeeksPerMonth(forThe: monthDate)
        let numberOfPostOffsetDatesForMonth = MSOutlookConstants.CalendarDays.numberOfDays * numberOfWeeksPerMonth - (countNumberOfDays + numberOfPreviousOffsetDates)
        return CalendarDatabaseConfiguration.Month(numberOfDaysInAMonth: countNumberOfDays, nameOfMonths: allMonths[eachMonthIndexName], startDate: startDate, endDate: endDate, preDatesForMonth: numberOfPreviousOffsetDates, postDatesForMonth: numberOfPostOffsetDatesForMonth)
        
    }
    /**
     This function `setUpMonth` create the array of Month`[CalendarDatabaseConfiguration.Month]`.
     - parameter withParams: We are passing `withParams`[`ConfigureCalendar`] structure.
     - returns: It will return the array of Month`[CalendarDatabaseConfiguration.Month]` for given start & end date of the calendar .
     */
    func setUpMonth(withParams: ConfigureCalendar) -> [CalendarDatabaseConfiguration.Month]{
        
        var initialMonths: [CalendarDatabaseConfiguration.Month] = []
        var monthDateComponents = withParams.calendar.dateComponents([.month], from: withParams.startDate, to: withParams.endDate)
        let numberOfMonthsForSetup = monthDateComponents.month ?? 1
        for months in 0..<numberOfMonthsForSetup{
            if let month = createMonth(withCalendar: withParams.calendar, startDate: withParams.startDate, monthIndex: months){
                initialMonths.append(month)
            }
        }
        return initialMonths
    }
}
/**
 `MSOutlookCalendarCellModel` defines `Calendar` configuration.
 - `monthString: String` - monthString of the calendar, i.e. APR, MAY etc.
 - `dateString: String` - dateString of the calendar, i.e. 01, 22, 31 etc.
 - `isDottedDate: Bool` - if events is present for the particular date.
 - `checkCurrentDate: Bool` - check todays date for the calendar.
 - `currentMonthBackGroundView: Bool` - Background of the Particular full month.
 */
struct MSOutlookCalendarCellModel{
    let monthString: String
    let dateString: String
    let isDottedDate: Bool
    let checkCurrentDate: Bool
    let currentMonthBackGroundView: Bool
}
/**
 `MSParentScreenActiveView` defines the Active view in `MSParentScreenViewController`.
 */
public enum MSParentScreenActiveView{
    case none
    case calendarView
    case agendaView
}
/**
 `MonthsInAYear` defines 12 months for the year.
 */
public enum MonthsInAYear{
    case Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
}
/**
 `CalendarConfigurationError` defines:
 - InvalidCalendar - It occurs in the catch block, if `ConfigureCalendar` doesn't execute.
  - EventGenerationError - It occurs if event generation failed from the JSON/Bundle.
 */
public enum CalendarConfigurationError: Error{
    case InvalidCalendar
    case EventGenerationError
}

