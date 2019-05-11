//
//  MSOutlookCalendarManager+Extension.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 26/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 `MSOutlookCalendarManager+Extension` is the main back bone for `Calendar+Agenda` Logic, `Calendar+Agenda` other functions are fall into here and it's called by `MSParentScreenInteractor`. In detail:
 
 - `CalendarDatabase` gets created here. which contains all the Model Object.
 - It's segregated it and written as an extension, as its an unique call from `MSParentScreenInteractor`.
 */
import Foundation

extension MSOutlookCalendarManager{
    /**
     This function `initCalendar()` returns the ` CalendarDatabaseConfiguration.CalendarDatabase` module.
     - listOfMonths: holds array of months needed to be shown.
     - calendarCells: holds number of collection cell in the Calendarview.
     - daysDifference: holds number of difference days from Calendar start date to Current date.
     - preDatesForMonth: holds preoffsetdate count for the month.
     - todayIndex: holds todays date index.
     - dayAgenda: holds array of agenda for particular date.
     */
    public func initCalendar() throws{
        guard let configureCalendar = configureCalendar() else {
            throw CalendarConfigurationError.InvalidCalendar
        }
        let listOfMonths = MonthConfiguration().setUpMonth(withParams: configureCalendar)
        let calendarCells = numberOfCollectionViewCells(months: listOfMonths)
        let daysDifference = getDaysDifference(fromDate: configureCalendar.startDate, toDate: Date()) ?? 0
        let preDatesForMonth = listOfMonths.first?.preDatesForMonth ?? 0
        let todayIndex = preDatesForMonth + daysDifference
        let dayAgenda = dayWiseAgenda(months: listOfMonths)
        calendarDatabase = CalendarDatabaseConfiguration.CalendarDatabase(startDateUpperRange: configureCalendar.startDate, endDateLowerRange: configureCalendar.endDate, month: listOfMonths, todaysCalendarDate: todayIndex, totalCalendarCellsInCollectionView: calendarCells, agenda: dayAgenda)
    }
    
}
