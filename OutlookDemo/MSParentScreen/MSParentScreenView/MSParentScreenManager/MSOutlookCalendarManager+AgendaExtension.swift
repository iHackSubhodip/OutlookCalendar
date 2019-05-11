//
//  MSOutlookCalendarManager+AgendaExtension.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 01/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 `MSOutlookCalendarManager+AgendaExtension` is a data manager class only for `AgendaView`, which contains the business logic and this logic are called from `initCalendar` `MSOutlookCalendarManager+Extension` properties, `MSOutlookCalendarManager+Extension`is called from `MSParentScreenInteractor`.
 - This space only contains Agenda related logic.
 */
import Foundation

extension MSOutlookCalendarManager{
    /**
     This function `eventGeneratorFromBundle()` decodes `AgendaEvents.json`. It's called from `dayWiseAgenda` method.
     - returns: updates `EveryDayAgendaEvents` model objects.
     - warning: throws `EventGenerationError` if decode failed.
     */
    func eventGeneratorFromBundle(date: Date) throws -> AgendaDatabaseConfig.EveryDayAgendaEvents?{
        if let jsonUrl = Bundle.main.url(forResource: "AgendaEvents", withExtension: "json"),let data = try? Data.init(contentsOf: jsonUrl){
            guard let events = try? JSONDecoder().decode(AgendaDatabaseConfig.EveryDayAgendaEvents.self, from: data) else{
                throw CalendarConfigurationError.EventGenerationError
            }
            var agendaEvents = events
            agendaEvents.date = date
            return agendaEvents
        }
        return nil
    }
    /**
     This function `allDayEvent()` adds common events for everyday[in which day event is there].
     - returns: updates `EveryDayAgendaEvents` model objects.
     */
    private func allDayEvent(date: Date) -> AgendaDatabaseConfig.EveryDayAgendaEvents {
        return AgendaDatabaseConfig.EveryDayAgendaEvents(title: MSOutlookConstants.MSOutlookManagerConstants.everyDayAgendaEvent, date: date, startTime: date, meetingPeople: [], allDayEvent: true)
    }
    /**
     This function `dayWiseAgenda()` add events into the `CalendarDatabase` and called into `initCalendar()``MSOutlookCalendarManager+Extension`.
     - schedules: holds [AgendaDatabaseConfig.EveryDayAgenda].
     - preDatesForMonth: preoffset for the month.
     - postDatesForMonth: postoffset for the month.
     
     • first foreach loop `months.forEach`:-
     - First foreach loop adds the `Calendar+Agenda` includes `startdate - preDatesForMonth` and runs upto `month.numberOfDaysInAMonth` starting from 0.
     
     • Second for loop `preDates in 0...preDatesForMonth`:-
     - `preDates in 0...preDatesForMonth` loop updates the `Calendar+Agenda` from where first foreach loop ends and runs for preDatesForMonth from 0. As we have started adding dates from `startdate - preDatesForMonth`.
     
     • Third foreach loop `postDates in 0..<postDatesForMonth - 1`:-
     - `postDates in 0..<postDatesForMonth - 1` loop updates the `Calendar+Agenda` from where second for loop ends. It runs for the postdates from 0.
     • Events added:
     - for each alternative date we are adding the events. `(i+1) % 2`,`(preDates+1) % 2`, `(postDates+1) % 2`.
     - returns: updates `AgendaDatabaseConfig.EveryDayAgenda` `schedules` model objects.
     */
    func dayWiseAgenda(months: [CalendarDatabaseConfiguration.Month]) -> [AgendaDatabaseConfig.EveryDayAgenda] {
        guard !months.isEmpty else {
            return []
        }
        var schedules: [AgendaDatabaseConfig.EveryDayAgenda] = []
        let preDatesForMonth = months.first?.preDatesForMonth ?? 0
        let postDatesForMonth = months.last?.postDatesForMonth ?? 0
        
        months.forEach { (month) in
            guard let startDate = currentCalendar.date(byAdding: .day, value: -preDatesForMonth, to: month.startDate) else{
                return
            }
            for i in 0..<month.numberOfDaysInAMonth {
                guard let eachDate = currentCalendar.date(byAdding: .day, value: i, to: startDate) else { return
                }
                lastDateForTheMonth = eachDate
                if (i+1) % 2 == 0 {
                    var dayEvents: [AgendaDatabaseConfig.EveryDayAgendaEvents] = []
                    if let event = try? eventGeneratorFromBundle(date: eachDate), let events = event {
                        dayEvents.append(events)
                    }
                    dayEvents.append(allDayEvent(date: eachDate))
                    schedules.append(AgendaDatabaseConfig.EveryDayAgenda(date: eachDate, agendaEvents: dayEvents))
                } else {
                    schedules.append(AgendaDatabaseConfig.EveryDayAgenda(date: eachDate, agendaEvents: []))
                }
            }
        }
        
        for preDates in 0...preDatesForMonth{
            let eachDate = currentCalendar.date(byAdding: .day, value: preDates + 1, to: lastDateForTheMonth ?? Date()) ?? Date()
            lastDateForPostOffsetPreviousMonth = eachDate
            if (preDates+1) % 2 == 0 {
                var dayEvents: [AgendaDatabaseConfig.EveryDayAgendaEvents] = []
                if let event = try? eventGeneratorFromBundle(date: eachDate), let events = event {
                    dayEvents.append(events)
                }
                dayEvents.append(allDayEvent(date: eachDate))
                schedules.append(AgendaDatabaseConfig.EveryDayAgenda(date: eachDate, agendaEvents: dayEvents))
            } else {
                schedules.append(AgendaDatabaseConfig.EveryDayAgenda(date: eachDate, agendaEvents: []))
            }
        }
        
        for postDates in 0..<postDatesForMonth - 1{
            let eachDate = currentCalendar.date(byAdding: .day, value: postDates + 1, to: lastDateForPostOffsetPreviousMonth ?? Date()) ?? Date()
            if (postDates+1) % 2 == 0 {
                schedules.append(AgendaDatabaseConfig.EveryDayAgenda(date: eachDate, agendaEvents: []))
            } else {
                var dayEvents: [AgendaDatabaseConfig.EveryDayAgendaEvents] = []
                if let event = try? eventGeneratorFromBundle(date: eachDate), let events = event {
                    dayEvents.append(events)
                }
                dayEvents.append(allDayEvent(date: eachDate))
                schedules.append(AgendaDatabaseConfig.EveryDayAgenda(date: eachDate, agendaEvents: dayEvents))
            }
        }
        return schedules
    }
}
