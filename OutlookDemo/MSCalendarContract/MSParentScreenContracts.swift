//
//  MSParentScreenContracts.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

/**
 There are list of protocols/contracts in this space.
 - Each module talk to each other via this list of required protocols.
 */
import Foundation
import UIKit
/**
 Protocol/Contract Name - `MSParentScreenBuilderProtocol`
 - Function Name - `parentScreenBuilder` [It helps to build `MSParentScreenViewController`, `Builder` for the `VIPER` architecture.]
 - returns - `MSParentScreenViewController` [Which creates the `VIPER` module and returns the `MSParentScreenViewController`]
 */
protocol MSParentScreenBuilderProtocol {
    func parentScreenBuilder() -> MSParentScreenViewController?
}
/**
 Protocol/Contract Name - `MSParentScreenViewProtocol`. Protocol Supports the View `V` of the `VIPER` architecture.
 
 • Function Name - `fetchDatabase` [It helps to fetch the `CalendarDatabase` for `MSCalendarView`.]
 - returns - `CalendarDatabaseConfiguration.CalendarDatabase?` [It returns the structure for `Calendar Database`.]
 
 • Function Name - `calendarExpanded` [Expands the `MSCalendarView` whenever required.]
 
 • Function Name - `calendarShrunk` [Shrunk the `MSCalendarView` whenever required.]
 
 • Function Name - `screenActiveViewGetter` [It helps to get which UIView subclass is responding in between `MSCalendarView` & `MSAgendaView`]
 - returns - `MSParentScreenActiveView` [which is an enum of `none`, `calendarView` & `agendaView`]
 
 • Function Name - `screenActiveViewSetter` [It helps to set which UIView subclass is responding in between `MSCalendarView` & `MSAgendaView`]
 - returns - `MSParentScreenActiveView` [which is an enum of `none`, `calendarView` & `agendaView`]
 
 • Function Name - `fetchCalendarView` [It helps to fetch `MSCalendarView` from seperate modules.]
 - returns - `MSCalendarView` [which is a `UICollectionView` consists of the Calendar.]
 
 • Function Name - `fetchAgendaView` [It helps to fetch `MSAgendaView` from seperate modules.]
 - returns - `MSAgendaView` [which is a `UITableView` consists of the Calendar Agenda.]
 
 • Function Name - `getMonthDescription` [It helps to set the Top stack view Month Label e.g."APR 2018"]
 - returns - `UILabel`
 
 • Function Name - `fetchWeatherData` [It helps to fetch weather data Model from seperate modules.]
 - returns - `MSOutlookWeatherModelData` [Returns the Model structure of the weather data.]
 
 • Function Name - `fetchLocationData` [It helps to fetch location data Model from seperate modules.]
 - returns - `MSOutlookLocationModel` [Returns the Model structure of the location data.]
 */
protocol MSParentScreenViewProtocol: class {
    func fetchDatabase() -> CalendarDatabaseConfiguration.CalendarDatabase?
    func calendarExpanded()
    func calendarShrunk()
    func screenActiveViewGetter() -> MSParentScreenActiveView
    func screenActiveViewSetter(withType: MSParentScreenActiveView)
    func fetchCalendarView() -> MSCalendarView?
    func fetchAgendaView() -> MSAgendaView?
    func getMonthDescription() -> UILabel?
    func fetchWeatherData() -> MSOutlookWeatherModelData?
    func fetchLocationData() -> MSOutlookLocationModel?
}
/**
 Protocol/Contract Name - `MSParentScreenPresenterProtocol`. Protocol Supports the Presenter `P` of the `VIPER` architecture.
 
 • Function Name - `initCalendar` [It initializes the Calendar module Database, It is called from `MSParentScreenViewController` `viewDidLoad`]
 
 • Function Name - `selectTodaysDate` [It helps to select today's date, It is called from `MSParentScreenViewController` `viewDidAppear`.]
 
 • Function Name - `fetchDatabase` [It helps to fetch the `CalendarDatabase` for `MSCalendarView`.]
 - returns - `CalendarDatabaseConfiguration.CalendarDatabase?` [It returns the structure for `Calendar Database`.]
 */
protocol MSParentScreenPresenterProtocol: class {
    func initCalendar()
    func selectTodaysDate()
    func fetchDatabase() -> CalendarDatabaseConfiguration.CalendarDatabase?
}
/**
 Protocol/Contract Name - `MSParentScreenInteractorProtocol`. Protocol Supports the Interactor `I` of the `VIPER` architecture.
 
 • Function Name - `initCalendar` [It initializes the Calendar module Database, It is called from `MSParentScreenPresenter`.]
 
 • Function Name - `fetchDatabase` [It helps to fetch the `CalendarDatabase` for `MSCalendarView`, It is called from `MSParentScreenPresenter`.]
 - returns - `CalendarDatabaseConfiguration.CalendarDatabase?` [It returns the structure for `Calendar Database`.]
 */
protocol MSParentScreenInteractorProtocol: class {
    func initCalendar()
    func fetchDatabase() -> CalendarDatabaseConfiguration.CalendarDatabase?
}
/**
 Protocol/Contract Name - `MSParentScreenRouterProtocol`. Protocol Supports the Router `R` of the `VIPER` architecture. In the current application, we are not navigating to any screen so this protocol isn't implemented.
 */
protocol MSParentScreenRouterProtocol: class {
    
}
/**
 Protocol/Contract Name - `WeatherManagerOutputProtocol`. Protocol Supports the output of the Weather API.
 
 • Function Name - `didFetchWeatherDetailSuccess` [It tells the `MSParentScreenViewController` that API response is successfully parsed.]
 
 • Function Name - `didFetchWeatherDetailFailure` [It tells the `MSParentScreenViewController` that API response is failed to be parsed.]
 */
protocol WeatherManagerOutputProtocol: class {
    func didFetchWeatherDetailSuccess()
    func didFetchWeatherDetailFailure()
}
