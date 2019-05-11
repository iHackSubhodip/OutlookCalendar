//
//  MSAgendaView.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 This class `MSAgendaView` consturcts the Agenda TableView and displays the TableViewcells.
 */
import UIKit

class MSAgendaView: UIView {
    // MARK: - instance properties
    weak var agendaDelegate: MSParentScreenViewProtocol?
    var topTableviewIndex: Int?
    var tableIndex = 0
    var agendaViewScrollDirection: ScrollDirection = .none
    var agendaTableView: UITableView!{
        didSet{
            agendaTableView.rowHeight = UITableViewAutomaticDimension
            agendaTableView.estimatedRowHeight = 100
        }
    }
    
    // MARK: - Awake Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        
    }
    // MARK: - TableView setup
    private func setupTableView(){
        agendaTableView = UITableView(frame: bounds)
        agendaTableView.delegate = self
        agendaTableView.dataSource = self
        agendaTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        agendaTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        agendaTableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        agendaTableView.separatorStyle = .none
        agendaTableView.allowsSelection = false
        registerTableViewCells()
        addSubview(agendaTableView)
        agendaTableView.reloadData()
    }
    // MARK: - TableViewCells setup
    private func registerTableViewCells(){
        agendaTableView.register(MSAgendaTableViewCell.self, forCellReuseIdentifier: MSOutlookConstants.AgendaCellView.agendaCell)
        agendaTableView.register(MSNoAgendaTableViewCell.self, forCellReuseIdentifier: MSOutlookConstants.AgendaCellView.noAgendaCell)
        agendaTableView.register(MSEveryDayAgendaTableViewCell.self, forCellReuseIdentifier: MSOutlookConstants.AgendaCellView.everyDayAgendaCell)
        agendaTableView.register(MSAgendaSetionHeaderFooter.self, forHeaderFooterViewReuseIdentifier: MSOutlookConstants.AgendaCellView.agendaSectionHeaderCell)
    }
    
}
// MARK: - UITableViewDelegate
extension MSAgendaView: UITableViewDelegate{
    /**
     This Delegate `willDisplayHeaderView` does:
     - When Tableview is scrolling to up direction, Collectionview will also scroll in up direction.`agendaViewScrollDirection == .up`.
     - tableIndex: is a the current section and set at `cellForRowAt`.
     - section: is set with the current delegate.
     - At the time of scrolling, in some scenarios absolute difference are more than 1 `abs(section - tableIndex) >= 1`[then scroll for both tableview & collectionviews are not elegant/proper]. Like when Collection view cell goes to the beginning/end of the calendar. So that time we are not scrolling the views, else we are scrolling both in the upper direction.
     */
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let firstTimeViewLoading = agendaDelegate?.fetchCalendarView()?.firstTimeViewLoading else {
            return
        }
        if !firstTimeViewLoading{
            topTableviewIndex = section
            if agendaViewScrollDirection == .up {
                if abs(section - tableIndex) >= 1{
                    return
                }else{
                    let indexPath = IndexPath(item: section, section: 0)
                    agendaDelegate?.fetchCalendarView()?.scrollToDate(indexPath, scrollIndex: .top)
                    agendaDelegate?.fetchCalendarView()?.collectionView.reloadData()
                }
            }
        }
    }
    /**
     This Delegate `didEndDisplayingHeaderView` does:
     - When Tableview is scrolling to down direction, Collectionview will also scroll in down direction.`agendaViewScrollDirection == .down`.
     - tableIndex: is a the current section and set at `cellForRowAt`.
     - section: is set with the current delegate.
     - At the time of scrolling, in some scenarios absolute difference are more than 4 `abs(section - tableIndex) >= 1`[then scroll for both tableview & collectionviews are not elegant/proper]. Like when Collection view cell goes to the beginning/end of the calendar. So that time we are not scrolling the views, else we are scrolling both in the upper direction.
     - why 4, as number of visible sections in tableview is 4. when it's a downward scroll `didEndDisplayingHeaderView` section returns last section for the tableview.
     */
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        guard let firstTimeViewLoading = agendaDelegate?.fetchCalendarView()?.firstTimeViewLoading else {
            return
        }
        if !firstTimeViewLoading{
            topTableviewIndex = section
            if agendaViewScrollDirection == .down {
                if abs(section - tableIndex) == 4{
                    let indexPath = IndexPath(item: section + 1, section: 0)
                    agendaDelegate?.fetchCalendarView()?.scrollToDate(indexPath, scrollIndex: .top)
                    agendaDelegate?.fetchCalendarView()?.collectionView.reloadData()
                    
                }else{
                    return
                }
            }
        }
    }
    /**
     This DataSource `heightForHeaderInSection` returns:
     - returns: height Of Sections in `CGFloat` format.
     */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    /**
     This DataSource `viewForHeaderInSection` returns:
     - returns: `UIView`, which sets the header of the tableview section.
     */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MSOutlookConstants.AgendaCellView.agendaSectionHeaderCell) as? MSAgendaSetionHeaderFooter else{ return nil }
        if let agenda = agendaDelegate?.fetchDatabase()?.agenda {
            let calendar = Calendar.current
            let date = agenda[section].date
            header.sectionTitle = DateFormatter().getFullDetails(for: date)
            if calendar.isDateInToday(date){
                header.sectionTitle = "Today • " + DateFormatter().getFullDetails(for: date)
                header.sectionTitleTextColor = UIColor(displayP3Red: 30.0/255.0, green: 144.0/255.0, blue: 1.0, alpha: 0.5)
            }else if calendar.isDateInTomorrow(date){
                header.sectionTitle = "Tomorrow • " + DateFormatter().getFullDetails(for: date)
                header.sectionTitleTextColor = UIColor.lightGray
            }else{
                header.sectionTitle = DateFormatter().getFullDetails(for: date)
                header.sectionTitleTextColor = UIColor.lightGray
            }
            agendaDelegate?.getMonthDescription()?.text = DateFormatter().monthDescription(date: date)
        }
        return header
    }
    
}

// MARK: - UITableViewDataSource
extension MSAgendaView: UITableViewDataSource{
    /**
     This DataSource `numberOfRowsInSection` returns `Int` value.
     - returns: number Of Rows in the Sections for the tableview, precisely returns count of agenda events, returns 1 if no agenda.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let agenda = agendaDelegate?.fetchDatabase()?.agenda, !agenda[section].agendaEvents.isEmpty{
            return agenda[section].agendaEvents.count
        }
        return 1
    }
    /**
     This DataSource `numberOfSections` returns `Int` value.
     - returns: number Of Sections for the tableview.
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return agendaDelegate?.fetchDatabase()?.agenda.count ?? 1
    }
    /**
     This DataSource `cellForRowAt` returns 3 types of cells:
     - MSNoAgendaTableViewCell: contains no AgendaCell.
     - MSEveryDayAgendaTableViewCell: contains common AgendaCell.
     - MSAgendaTableViewCell: contains AgendaCell with Location, Weather and Meetings.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let agenda = agendaDelegate?.fetchDatabase()?.agenda else {
            return UITableViewCell()
        }
        tableIndex = indexPath.section
        if agenda[indexPath.section].agendaEvents.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MSOutlookConstants.AgendaCellView.noAgendaCell, for: indexPath) as? MSNoAgendaTableViewCell else {
                return  UITableViewCell()
            }
            return cell
        } else {
            let agendaModel = agenda[indexPath.section].agendaEvents[indexPath.row]
            if agendaModel.allDayEvent {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MSOutlookConstants.AgendaCellView.everyDayAgendaCell, for: indexPath) as? MSEveryDayAgendaTableViewCell else {
                    return UITableViewCell()
                }
                cell.everyDayAgendaModel = agendaModel
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MSOutlookConstants.AgendaCellView.agendaCell, for: indexPath) as? MSAgendaTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.weatherModel = agendaDelegate?.fetchWeatherData()
                cell.locationModel = agendaDelegate?.fetchLocationData()
                cell.agendaModel = agendaModel
                
                return cell
            }
        }
    }
    
}
// MARK: - UIScrollViewDelegate
extension MSAgendaView: UIScrollViewDelegate{
    /**
     This DataSource `scrollViewDidScroll` returns:
     - returns: scroll direction for calendar view.
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        agendaViewScrollDirection = scrollView.panGestureRecognizer.translation(in: scrollView).y > 0 ? .up : .down
    }
    /**
     This Delegate `scrollViewWillBeginDragging` does:
     - Moves Table with Collectionview, method called `loadAgendaTableViewWhileMovingFromCalendar()`.
     - Make Collectionview shrunk, method called `calendarShrunk()`.
     - set the responding view.
     */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        loadAgendaTableViewWhileMovingFromCalendar()
        agendaDelegate?.calendarShrunk()
        agendaDelegate?.fetchCalendarView()?.firstTimeViewLoading = false
        agendaDelegate?.screenActiveViewSetter(withType: .agendaView)
    }
}

// MARK: - AgendaView Scroll with Calendar
extension MSAgendaView{
    private func loadAgendaTableViewWhileMovingFromCalendar() {
        guard agendaDelegate?.screenActiveViewGetter() != .agendaView, let firstTimeViewLoading = agendaDelegate?.fetchCalendarView()?.firstTimeViewLoading  else { return }
        if !firstTimeViewLoading{
            self.agendaTableView.scrollToRow(at: IndexPath(row: 0, section: self.topTableviewIndex ?? 0), at: .top, animated: false)
        }
    }
}
