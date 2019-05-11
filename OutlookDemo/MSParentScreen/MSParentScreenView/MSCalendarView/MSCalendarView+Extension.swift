//
//  MSCalendarViewManager.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 28/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 In This class extension `MSCalendarView` contains all the helper methods for `MSCalendarView`.
 - So It's segeregated as an Extension.
 */
import UIKit

extension MSCalendarView{
    /**
     This function `initCalendarCell` creates `MSOutlookCalendarCellModel`.
     - parameter cellModel: shares `CalendarDatabaseConfiguration` is the main backbone for making the `Calendar`
     - returns: It will return `MSOutlookCalendarCellModel` and update the cell model at `cellforRowAt`.
     */
    func initCalendarCell(_ cellModel: CalendarDatabaseConfiguration.CalendarDatabase, index: Int) -> MSOutlookCalendarCellModel?{
        guard index < cellModel.agenda.count else{
            return nil
        }
        let date = cellModel.agenda[index].date
        let dateString = DateFormatter().getDate(date: date)
        var monthString = ""
        if dateString == "01"{
            if let month = Int(DateFormatter().getMonth(date: date)) {
                monthString = MSOutlookConstants.CalendarMonths.months[month-1]
            }
        }
        if let month = Int(DateFormatter().getMonth(date: date)) {
            switch month{
            case let x where x%2 == 0:
                currentMonthBackGroundView = true
            default:
                currentMonthBackGroundView = false
            }
        }
        let today = Calendar.current.startOfDay(for: Date())
        let currentDate = date.compare(today) == ComparisonResult.orderedSame
        let dottedDate = !cellModel.agenda[index].agendaEvents.isEmpty
        return MSOutlookCalendarCellModel(monthString: monthString, dateString: dateString, isDottedDate: dottedDate, checkCurrentDate: currentDate, currentMonthBackGroundView: currentMonthBackGroundView)
    }
    /**
     This function `collectionViewGrayBackgrundView` creates the .gray background for alternative months.
     */
    func collectionViewGrayBackgrundView(_ withCell: UICollectionViewCell) -> UIView{
        let view = UIView(frame: withCell.bounds)
        view.backgroundColor = UIColor(displayP3Red: 0.86, green: 0.86, blue: 0.86, alpha: 0.3)
        return view
    }
    /**
     This function `collectionViewWhiteBackgrundView` creates the .white background for alternative months.
     */
    func collectionViewWhiteBackgrundView(_ withCell: UICollectionViewCell) -> UIView{
        let view = UIView(frame: withCell.bounds)
        view.backgroundColor = .white
        return view
    }
    /**
     This function `setCollectionViewContentOffset` sets the scrollview offset.
     - If the Collectioncell is scrolled, where the scrolling will end.
     - Meanwhile you'll never be see half of the cell.
     */
    func setCollectionViewContentOffset(_ view: UICollectionView,scrollView: UIScrollView){
        
        let currentRowOffset = view.contentOffset.y
        let currentRowHeight = view.frame.size.width/7 - 1
        let currentRowIndex = currentRowOffset / currentRowHeight
        let currentRowNumber = Int(currentRowIndex)
        if currentRowIndex >= (CGFloat(currentRowNumber) + 0.5){
            scrollView.setContentOffset(CGPoint(x: view.contentOffset.x, y: currentRowHeight * currentRowIndex.rounded()), animated: true)
        }else{
            scrollView.setContentOffset(CGPoint(x: view.contentOffset.x, y: currentRowHeight * currentRowIndex.rounded()), animated: true)
        }
    }
    /**
     This function `scrollToDate` scroll to date after selecting the date in the Collectionview.
     */
    func scrollToDate(_ indexPath: IndexPath, scrollIndex: UICollectionViewScrollPosition){
        guard collectionView.isIndexPathAvailable(indexPath) else {
            return
        }
        collectionView.scrollToItem(at: indexPath, at: scrollIndex, animated: true)
        if let previousDaySelection = checkCalendarPrevDaySelection, let cell = collectionView.cellForItem(at: previousDaySelection) {
            cell.isSelected = false
            cellStatusDictionary[previousDaySelection.row] = false
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MSCalendarCollectionViewCell{
            cell.isSelected = true
            cellStatusDictionary[indexPath.row] = true
            checkCalendarPrevDaySelection = indexPath
            checkCurrentDateValue = true
            
        }
    }
    /**
     This function `searchInAgendaView` helps to:
     - search the date in the `AgendaView` which is shown into the `Collectionview`.
     - After selecting the cell, first it will search the date in the AgendaView and on completion It scrolls to CollectionView.
     */
    func searchInAgendaView(calendarIndexPath: IndexPath, completionBlock: (() -> Void)? = nil) {
        let section = calendarIndexPath.item
        guard section >= 0 else { return }
        calendarDelegate?.fetchAgendaView()?.topTableviewIndex = section
        calendarDelegate?.fetchAgendaView()?.agendaTableView.reloadData()
        
        guard let numberOfSections = calendarDelegate?.fetchAgendaView()?.agendaTableView.numberOfSections, section < numberOfSections else {
            return
        }
        let tableIndexPath = IndexPath(row: 0, section: section)
        dateTappedByUser = true
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard let selfObject = self else{
                return
            }
            selfObject.calendarDelegate?.fetchAgendaView()?.agendaTableView?.scrollToRow(at: tableIndexPath, at: .top, animated: true)
            }, completion: { [weak self] (finish) in
                guard let selfObject = self else{
                    return
                }
                selfObject.dateTappedByUser = false
                completionBlock?()
        })
    }
    
}
