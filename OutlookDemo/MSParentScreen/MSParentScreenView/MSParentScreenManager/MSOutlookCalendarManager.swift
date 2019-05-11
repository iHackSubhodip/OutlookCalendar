//
//  MSOutlookManager.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 25/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 `MSOutlookCalendarManager` is a data manager class for `CalendarView`, which contains the business logic and this logic are called from `initCalendar` `MSOutlookCalendarManager+Extension` properties, `MSOutlookCalendarManager+Extension`is called from `MSParentScreenInteractor`. In detail:
 
 - There is a method in `MSParentScreenInteractor` `initCalendar()` which creates Calendar Database data. and it's data is managed by the `MSOutlookCalendarManager` class.
 */
import Foundation

final class MSOutlookCalendarManager{
    // MARK: - instance properties
    let currentCalendar = Calendar.current
    let currentDate = Date()
    var totalNumberOfCollectionViewCells = 0
    var calendarDatabase: CalendarDatabaseConfiguration.CalendarDatabase?
    var lastDateForTheMonth: Date?
    var lastDateForPostOffsetPreviousMonth: Date?
    
    /**
     This function `configureCalendar()` initializes the Calendar module.
     - This method get called from `initCalendar` `MSOutlookCalendarManager+Extension`, which calculates `configureCalendar` property.
     - `-1` is for the starting month will be one less month from current date.
     - `12` is for the ending month will be more than 12 months/1 year from current date.
     - so year are setting 13 months for the calendar in One shot.
     */
    func configureCalendar() -> ConfigureCalendar?{
        guard let previousMonthStartDate = currentCalendar.date(byAdding: .month, value: -1, to: currentDate),
            let startOfCalendarDate = currentCalendar.startOfMonth(forThe: previousMonthStartDate),
            let lastMonthDate = currentCalendar.date(byAdding: .month, value: 12, to: currentDate),
            let lastMonthEndDate = currentCalendar.startOfMonth(forThe: lastMonthDate)
            else {
                return nil
        }
        return ConfigureCalendar(startDate: startOfCalendarDate, endDate: lastMonthEndDate, calendar: currentCalendar)
    }
    /**
     This function `numberOfCollectionViewCells()` gives number of collectionviewcell to be be displayed in the `CalendarCollectionView`.
     - This method get called from `initCalendar` `MSOutlookCalendarManager+Extension`, which calculates `calendarCells` property.
     */
    func numberOfCollectionViewCells(months: [CalendarDatabaseConfiguration.Month]) -> Int{
        guard !months.isEmpty else {
            return 0
        }
        let preDates = months.first?.preDatesForMonth ?? 0
        let postDates = months.last?.postDatesForMonth ?? 0
        months.forEach { (month) in
            totalNumberOfCollectionViewCells += month.numberOfDaysInAMonth
        }
        return totalNumberOfCollectionViewCells + preDates + postDates
    }
    /**
     This function `getDaysDifference()` gives number of difference days from Calendar start date to Current date.
     - This method get called from `initCalendar` `MSOutlookCalendarManager+Extension`, which calculates `daysDifference` property.
     */
    func getDaysDifference(fromDate: Date?, toDate: Date?) -> Int? {
        
        guard let startDate = fromDate, let endDate = toDate else {
            return nil
        }
        let date1 = currentCalendar.startOfDay(for: startDate)
        let date2 = currentCalendar.startOfDay(for: endDate)
        let dateComponents = currentCalendar.dateComponents([.day], from: date1, to: date2)
        return dateComponents.day
    }
    
}
