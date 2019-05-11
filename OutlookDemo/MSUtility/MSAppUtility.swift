//
//  MSAppUtility.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

/**
 This structure(Value type) -> `MSOutlookConstants` contains all Application utility static constants.
 */
import Foundation

struct MSOutlookConstants{
    
    // MARK: - Calendar Days Structure
    struct CalendarDays{
        static let days = ["S", "M", "T", "W", "T", "F", "S"]
        static let numberOfDays = 7
    }
    
    // MARK: - Calendar Months Structure
    struct CalendarMonths{
        static let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    }
    
    // MARK: - Bottom Stack View Images
    struct BottomStackImages{
        static let calendarImage = "calendar"
        static let mailImage = "mail"
        static let searchImage = "search"
    }
    
    // MARK: - Calendar Collection Cellview
    struct CalendarCellView{
        static let calendarCell = "CalendarCell"
        static let separatorDecorationView = "separator"
        static let calendarCellShrunkHeight = 117.0
        static let calendarCellExpandedHeight = 290.0
    }
    
    // MARK: - Agenda Table Cellview
    struct AgendaCellView{
        static let agendaCell = "AgendaCell"
        static let noAgendaCell = "noAgendaCell"
        static let everyDayAgendaCell = "everyDayAgendaCell"
        static let agendaSectionHeaderCell = "agendaSectionHeaderCell"
    }
    
    // MARK: - No Agenda Table Cellview
    struct NoAgendaCellView {
        static let noAgendaCellLabel = "No Events."
    }
    
    // MARK: - Every day Agenda Table Cellview
    struct EveryDayAgendaCellView {
        static let everyDayAgendaCellLabel = "All Day"
    }
    
    // MARK: - Data Manager constant
    struct MSOutlookManagerConstants{
        static let everyDayAgendaEvent = "Outlook iOS all hands."
    }
    
    // MARK: - Weather Endpoint and Weather JSON Parameter
    struct MSWeather{
        static let weatherAPI = "https://api.darksky.net/forecast/dd4e55ff06515b974993ce78b82b1695/"
        static let data = "data"
        static let time = "time"
        static let summary = "summary"
        static let icon = "icon"
        static let daily = "daily"
        static let waitToReload = "Please wait..."
    }
    
    // MARK: - Weather Type Parameter
    struct WeatherIcon {
        static let clearDay = "clear-day"
        static let clearNight = "clear-night"
        static let rain = "rain"
        static let snow = "snow"
        static let sleet = "sleet"
        static let wind = "wind"
        static let fog = "fog"
        static let cloudy = "cloudy"
        static let partlyCloudyDay = "partly-cloudy-day"
        static let partlyCloudyNight = "partly-cloudy-night"
    }
    
    // MARK: - Common Utility constant
    static let emptyString = ""
    static let emptyLocation = "..."
    static let defaultWeather = "Clear throughout the day."
    static let failedData = "Failed to retrive weather data."
    
}

final class MSAppUtility{
    /**
     This class function `epochToDate` converts `epoch`[`TimeInterval`] to `Date`.
     - parameter epoch: We are passing `epoch` `TimeInterval`, which is being received by Weather API JSON.
     - returns: `Date` to the Application.
     */
    class func epochToDate(epoch: TimeInterval) -> Date {
        let date = Date(timeIntervalSince1970: epoch)        
        return DateFormatter().convertEpochToDate(date: date)
    }
}

