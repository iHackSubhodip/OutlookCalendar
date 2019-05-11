//
//  MSCalendarView.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 This Class `MSCalendarView` consturcts the Calendar CollectionView and displays the CollectionViewcells.
 */
import UIKit

class MSCalendarView: UIView {
    // MARK: - instance properties
    weak var calendarDelegate: MSParentScreenViewProtocol?
    var collectionView: UICollectionView!
    var currentMonthBackGroundView = false
    var dateTappedByUser = false
    var cellStatusDictionary:[Int:Bool] = [:]
    var checkCurrentDateValue = false
    var checkCalendarPrevDaySelection: IndexPath?
    var firstTimeViewLoading = true
    // MARK: - Awake Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    // MARK: - setup collection view
    private func setupCollectionView(){
        let collectionViewLayout = MSCalendarFlowlayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = true
        registerCollectionViewCells()
        addSubview(collectionView)
    }
    // MARK: - register collection view
    private func registerCollectionViewCells(){
        collectionView.register(MSCalendarCollectionViewCell.self, forCellWithReuseIdentifier: MSOutlookConstants.CalendarCellView.calendarCell)
    }
    
}
// MARK: - UICollectionViewDelegate
extension MSCalendarView: UICollectionViewDelegate{
    /**
     This `didSelectItemAt` selects the item at Collectionview.
     - `scrollToDate` is called for selection, is written in the class extension.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        firstTimeViewLoading = true
        searchInAgendaView(calendarIndexPath: indexPath) { [weak self] in
            guard let selfObject = self else{
                return
            }
            selfObject.scrollToDate(indexPath, scrollIndex: .top)
            selfObject.collectionView.reloadItems(at: [indexPath])
        }
        
    }
    /**
     This `didDeselectItemAt` deselects the item at Collectionview.
     */
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MSCalendarCollectionViewCell{
            cell.isSelected = false
            cellStatusDictionary[indexPath.row] = false
        }
    }
}
// MARK: - UICollectionViewDataSource
extension MSCalendarView: UICollectionViewDataSource{
    /**
     This `cellForItemAt` data source object for the cell that corresponds to the specified item in the collection view.
     - `initCalendarCell` initializes the calendar cells.
     - It also holds the current cell selection.
     - sets the cells background view.
     - holds previous cell selection.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MSOutlookConstants.CalendarCellView.calendarCell, for: indexPath) as? MSCalendarCollectionViewCell,
            let cellDataSource = calendarDelegate?.fetchDatabase() else{
                return UICollectionViewCell()
        }
        cell.cellModel = initCalendarCell(cellDataSource, index: indexPath.row)
        cell.backgroundView = cell.cellModel?.currentMonthBackGroundView == true ? collectionViewGrayBackgrundView(cell) : collectionViewWhiteBackgrundView(cell)
        if cell.cellModel?.checkCurrentDate == true && checkCurrentDateValue == false{
            cell.isSelected = true
            cellStatusDictionary[indexPath.row] = false
            checkCalendarPrevDaySelection = indexPath
        }else{
            if let checkCalendarPrevDaySelectionRow = checkCalendarPrevDaySelection?.row{
                
                if checkCalendarPrevDaySelectionRow == indexPath.row{
                    cell.isSelected = cellStatusDictionary[checkCalendarPrevDaySelectionRow] ?? false
                    cellStatusDictionary[indexPath.row] = true
                    checkCalendarPrevDaySelection = indexPath
                }
            }
        }
        return cell
    }
    /**
     This `numberOfItemsInSection` decides number of items in the section.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarDelegate?.fetchDatabase()?.totalCalendarCellsInCollectionView ?? 0
    }
    
}
// MARK: - UICollectionViewDelegateFlowLayout
extension MSCalendarView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/7, height: frame.width/7 - 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
// MARK: - UIScrollViewDelegate
extension MSCalendarView: UIScrollViewDelegate{
    /**
     This `scrollViewDidEndDecelerating` sets the calendarview row offset, when the scroll view has ended decelerating the scrolling movement.
     - Basically in Collectionview It will never show up a half row, Full row will be visible.
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setCollectionViewContentOffset(collectionView, scrollView: scrollView)
    }
    /**
     This `scrollViewDidEndDragging` sets the calendarview row offset, when dragging ended in the scroll view.
     - Basically in Collectionview It will never show up a half row, Full row will be visible.
     */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setCollectionViewContentOffset(collectionView, scrollView: scrollView)
    }
    /**
     This `scrollViewWillBeginDragging` helps to:
     - Expand Calendar.
     - set the active view.
     - check if the view is losded for the first time.
     */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        calendarDelegate?.calendarExpanded()
        firstTimeViewLoading = true
        if calendarDelegate?.screenActiveViewGetter() == .calendarView{
            calendarDelegate?.screenActiveViewSetter(withType: .calendarView)
        }else{
            calendarDelegate?.screenActiveViewSetter(withType: .agendaView)
        }
    }
}
