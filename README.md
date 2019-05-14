# OutlookDemo Project:

## Video Link:-

https://youtu.be/owXMSnh6p-s

## (1) Problem Statement :-



Build an iOS app that replicates the basic features described below of the Calendar and Agenda views on the Outlook iOS (iPhone) app.



(1.1) Requirements :-



• The Calendar view is a continuously scrolling view that allows the user to browse between days of the year. Tapping on a date should update the information displayed in the Agenda view.



• The Agenda view is a continuously scrolling view that allows the user to browse events in chronological order. Moving between dates should update the information displayed in the Calendar view.



• Make sure the expansion and contraction interaction between the Calendar view and Agenda view is fast and fluid



• Use a static data set for your calendar events



(1.2) Bonus: Networking Challenge : -



• Integrate an internet data source to retrieve the weather forecast for the user's device location. Display that information wherever you think makes the most sense.






## (2) Solution :-



• Application contains the calendar view and the calendar view dates provides its agenda for the tapped date on calendar view.


-------------------------------------------->

#### (2.1) View Setup :-



(2.1.1) Top View : It consists of Month description Label.



(2.1.2) Horizontal stackview: which is  for Days(M, T, W, etc..)



(2.1.3) Calendar View : below that One UiView [inside UiView there is programatically written collectionview for Calendar(only UiView is there in the storyboard)]



(2.1.4) Agenda View : below that one UIView for Agenda[inside UiView there is programatically written tableview for Agenda(only UiView is there in the storyboard)]



(2.1.5) In bottom another stackview for sliding buttons [where one is calendar button, another is search button, another is email button]



-------------------------------------------->


#### (2.2) Architecture:



• I have followed VIPER design pattern, so that each module can talk to themselves independently, via protocol delegates (`MSParentScreenContracts`).



• Builder :  `MSParentScreenBuilder.swift`

• View :  `MSParentScreenViewController.swift`, `MSCalendarView.swift` & `MSAgendaView.swift`.

• Interactor :  `MSParentScreenInteractor.swift`

• Presenter :  `MSParentScreenPresenter.swift`

• Entity :  `MSOutlookCalendarModel.swift`,`MSOutlookAgendaModel.swift`,
`MSOutlookWeatherModel.swift` & `MSOutlookLocationModel.swift`.

• Router :  `MSParentScreenRouter.swift`

• Data - Managers :  `MSOutlookCalendarManager.swift` & `MSOutlookWeatherManager.swift`.


-------------------------------------------->


#### (2.3) Main Application Files :-


(2.3.1) MSParentScreen: [I have used `MS` prefix for `Microsoft`]


#### MSParentScreenView: (`MSParentScreenViewController.swift`)

- It contains two independent views (1) Calendar View, (2) Agenda View. Those are independent and talk to each other by protocol delegates.

• MSCalendar View: (`MSCalendarView.swift`)

- It contains a Collection view. For data it asks the MSParentScreenViewController who asks further MSParentScreenPresenter to provide the data.


• MSAgenda View: (`MSAgendaView.swift`)

- It contains a Table view. For data it asks the MSParentScreenViewController who asks further MSParentScreenPresenter to provide the data.

#### MSParentScreenManager: ( `MSOutlookCalendarManager.swift` & `MSOutlookWeatherManager.swift`.)

-  `MSOutlookCalendarManager` is a data manager class for `CalendarView`, which contains the business logic and this logic are called from `initCalendar` `MSOutlookCalendarManager+Extension` properties, `MSOutlookCalendarManager+Extension`is called from `MSParentScreenInteractor`.

- Currently I am loading past 12 months from current date and post 1 month from the current date. It can be altered in the code as per the requirement. code looks like

`
guard let previousMonthStartDate = currentCalendar.date(byAdding: .month, value: -1, to: currentDate),
    let startOfCalendarDate = currentCalendar.startOfMonth(forThe: previousMonthStartDate),
    let lastMonthDate = currentCalendar.date(byAdding: .month, value: 12, to: currentDate),
    let lastMonthEndDate = currentCalendar.startOfMonth(forThe: lastMonthDate)
    else {
        return nil
        }
`
It's in `MSOutlookCalendarManager`.


- `MSOutlookWeatherManager` is a data manager class for `WeatherView` elements, which contains the logic for parsing weather JSON Object. This class updates `MSOutlookWeatherModelData` model objects.



#### MSParentScreenInteractor: (`MSParentScreenInteractor.swift`)

• This class `MSParentScreenInteractor` is the backbone of an application as it contains the business logic and the logic is managed by respective Data Managers. In detail:

- It has all the business logic which is managed by `calendarManager`[`MSOutlookCalendarManager`] & `weatherManager`[`MSOutlookWeatherManager`].


#### MSParentScreenPresenter: (`MSParentScreenPresenter.swift`)

•This class `MSParentScreenPresenter` has the responsibility:

- to get the data from the interactor on user actions and after getting data from the interactor`MSParentScreenInteractor`, it sends it to the view to show it.

- It also asks the router for navigation logic.


#### MSParentScreenEntity: (`MSOutlookCalendarModel.swift`, `MSOutlookAgendaModel.swift`,
`MSOutlookWeatherModel.swift` & `MSOutlookLocationModel.swift`.)

• It contains the entities, which are the basic model objects used by the Interactor.


#### MSParentScreenRouter: (`MSParentScreenRouter.swift`)

• This class `MSParentScreenRouter` supports navigation logic.



-------------------------------------------->


#### (2.4) Networking :-


#### MSNetworking:

Only Seven days from Current day weather data are shown in the `MSAgendaTableViewCell`, and rest days weather are hardcoded as `Clear throughout the day.`

• `MSNetworkingClass.swift`

- This Networking class MSNetworkingClass supports networking using `URl`, `URLSession`, `URLSessionDataTask`, `HTTPURLResponse`, `JSONSerialization`. It supports:
- GET Request
- decodingTask -> `URLSessionDataTask`

• `MSAPIError.swift`

- This enum(value type) -> `MSAPIError` contains the following API error response:
- Request Failed.
- Invalid Data.
- Response Unsuccessful.
- JSON Parsing Failure.
- JSON Conversion Failure.

• `MSWeatherAPIResult.swift`

- This enum(value type) -> `MSWeatherAPIResult` contains the following API response:
- Success Result from `JSON API, <T>` represents Generics type.
- Failure Result from `JSON API, <U>` represents Error type.

• URL Used: (`https://api.darksky.net/forecast/dd4e55ff06515b974993ce78b82b1695/`) it's in `MSAppUtility.swift`.


-------------------------------------------->


#### (2.5) Location :-

• Showing Current location in the `MSAgendaTableViewCell`. It will update in the location on the change of 1km
`locationManager.distanceFilter = 1000.0` written in `AppDelegate.swift`.




-------------------------------------------->


#### (2.6) Static data set :-

• It's there in the project file `AgendaEvents.json` in `MSParentScreenEntity` folder.



## (3) Highlights :

• No third party libs are used.

• View hierarchies are written by code.

• Unit testing provided, with Code coverage of 65%.

• Network Layer using URLSession to retrieve weather's data using user's device location.




### Best,
#### Subhodip








