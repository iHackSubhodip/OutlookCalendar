//
//  MSParentScreenInteractor.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 This class `MSParentScreenInteractor` is the backbone of an application as it contains the business logic and the logic is managed by respective Data Managers. In detail:
 
 - It has all the business logic which is managed by `calendarManager`[`MSOutlookCalendarManager`] & `weatherManager`[`MSOutlookWeatherManager`].
 */

import Foundation

class MSParentScreenInteractor: MSParentScreenInteractorProtocol{
    
    // MARK: - instance properties
    var parentScreenRouter: MSParentScreenRouterProtocol?
    weak var parentScreenPresenter: MSParentScreenPresenter?
    let calendarManager = MSOutlookCalendarManager()
    let weatherManager = MSOutlookWeatherManager()
    
    // MARK: - initialization
    init(router: MSParentScreenRouterProtocol?, presenter: MSParentScreenPresenter?) {
        self.parentScreenRouter = router
        self.parentScreenPresenter = presenter
    }
    /**
     This function `initCalendar()` initializes the Calendar module Database.
     - From here `calendarManager [MSOutlookCalendarManager()]` object is called, which initiates/forms the `MSOutlookCalendarManager` data.
     - warning: It will catch the error whether it's an `InvalidCalendar` & `Unknown error`.
     */
    func initCalendar() {
        do{
            try calendarManager.initCalendar()
        }catch CalendarConfigurationError.InvalidCalendar{
            print("Invalid calendar.")
        }catch {
            print("Unknown error.")
        }
    }
    /**
     This function `fetchDatabase()` fetch the `CalendarDatabase`.
     - From here `weatherManager [MSOutlookWeatherManager()]` object is called, which initiates/forms the `MSOutlookWeatherManager` data.
     - return: `CalendarDatabaseConfiguration.CalendarDatabase?` [It returns the structure for `Calendar Database`.].
     */
    func fetchDatabase() -> CalendarDatabaseConfiguration.CalendarDatabase? {
        return calendarManager.calendarDatabase
    }
    
}


