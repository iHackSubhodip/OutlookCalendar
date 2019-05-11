//
//  MSParentScreenPresenter.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 This class `MSParentScreenPresenter` has the responsibility:
    - to get the data from the interactor on user actions and after getting data from the interactor`MSParentScreenInteractor`, it sends it to the view to show it.
    - It also asks the router for navigation logic.
 */

import Foundation

class MSParentScreenPresenter: MSParentScreenPresenterProtocol{
    // MARK: - instance properties
    public var parentScreenInteractor: MSParentScreenInteractorProtocol?
    weak var parentScreenView: MSParentScreenViewProtocol?
    // MARK: - initialization
    init(view: MSParentScreenViewProtocol?) {
        parentScreenView = view
    }
    /**
     This function `initCalendar()` used for initializing Calendar data from the interactor`MSParentScreenInteractor`.
     */
    func initCalendar() {
        parentScreenInteractor?.initCalendar()
    }
    /**
     This function `fetchDatabase()` used for fetching `CalendarDatabaseConfiguration.CalendarDatabase` data from the interactor`MSParentScreenInteractor`.
     */
    func fetchDatabase() -> CalendarDatabaseConfiguration.CalendarDatabase? {
        return parentScreenInteractor?.fetchDatabase()
    }
    /**
     This function `selectTodaysDate()` used for selecting the present date into the `MSCalendarView`.
     - warning: used [weak self] for the closure, It's works as a capture list. If self becomes nil it can crash. So that We have introduced `guard let selfObject`. It will return if `self` is `nil`.
     */
    func selectTodaysDate() {
        guard let todaysDateIndex = parentScreenInteractor?.fetchDatabase()?.todaysCalendarDate else{
            return
        }
        let todaysCalendarDateIndexPath = IndexPath(item: todaysDateIndex, section: 0)
        parentScreenView?.calendarShrunk()
        parentScreenView?.fetchCalendarView()?.collectionView.reloadData()
        parentScreenView?.fetchCalendarView()?.searchInAgendaView(calendarIndexPath: todaysCalendarDateIndexPath, completionBlock: { [weak self] in
            guard let selfObject = self else{
                return
            }
            selfObject.parentScreenView?.fetchCalendarView()?.scrollToDate(todaysCalendarDateIndexPath, scrollIndex: .top)
        })
    }
    
}
