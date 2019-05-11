//
//  MSParentScreenViewController.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

/**
 ## Feature Support
 
 This Class `MSParentScreenViewController` contains the full shown View Controller.
 - It sends the user actions to the presenter and shows whatever the presenter tells it.
 */
import UIKit
import CoreLocation

class MSParentScreenViewController: UIViewController{
    // MARK: - instance properties
    var parentPresenter: MSParentScreenPresenterProtocol?
    var parentScreenActiveView: MSParentScreenActiveView = .none
    weak var parentScreenView: MSParentScreenViewProtocol?
    var defaultLocationLatitude: CLLocationDegrees = 12.923495
    var defaultLocationLongitude: CLLocationDegrees = 77.685107
    lazy var currentLocation: CLLocation = CLLocation(latitude: defaultLocationLatitude, longitude: defaultLocationLongitude)
    var weatherManager = MSOutlookWeatherManager()
    let geoCoder = CLGeocoder()
    var locationModelData: MSOutlookLocationModel?
    
    // MARK: - IBOutlet
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewDescriptionLabel: UILabel!
    @IBOutlet weak var dayStackView: UIStackView!{
        didSet{
            dayStackView.distribution = .fillEqually
            dayStackView.axis = .horizontal
        }
    }
    
    @IBOutlet weak var calendarView: MSCalendarView!{
        didSet{
            calendarView.calendarDelegate = self
        }
    }
    
    @IBOutlet weak var agendaView: MSAgendaView!{
        didSet{
            agendaView.agendaDelegate = self
        }
    }
    
    @IBOutlet weak var bottomStackView: UIStackView!{
        didSet{
            bottomStackView.distribution = .fillEqually
            bottomStackView.axis = .horizontal
        }
    }
    
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        appDelegate.locationManager.delegate = self
        weatherManager.weatherDelegate = self
        parentPresenter?.initCalendar()
        setupDayStackView()
        setupBottomStackView()
        setupCalendarHeight()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectTodaysDate()
    }
    /**
     This `setupDayStackView` sets the top stack view for days.
     */
    private func setupDayStackView(){
        MSOutlookConstants.CalendarDays.days.forEach { (dayValue) in
            let dayValue = UILabel.getTextLabel(dayValue: dayValue)
            dayStackView.addArrangedSubview(dayValue)
        }
    }
    /**
     This `reverseGeocode` reverse geocode the current location.
     - parameter `currentLocation`: passes current location.
     - updates `MSOutlookLocationModel` model data.
     - warning: if location is nil, it sets hardcoded "XYZ, India" into the model.
     */
    private func reverseGeocode(currentLocation: CLLocation){
        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks, error) -> Void in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            guard let place = placeMark, let locationName = place.name, let country = place.country else{
                let locationModelData = MSOutlookLocationModel(countryName: "India", localityName: "XYZ")
                self.locationModelData = locationModelData
                return
            }
            let locationModelData = MSOutlookLocationModel(countryName: country, localityName: locationName)
            self.locationModelData = locationModelData
            DispatchQueue.main.async(execute: {
                self.agendaView?.agendaTableView.reloadData()
            })
        })
    }
    /**
     This `setupBottomStackView` sets the bottom stack view for calendar, search, weather button.
     */
    private func setupBottomStackView(){
        let calendarButton = UIButton.getButton(image: MSOutlookConstants.BottomStackImages.calendarImage)
        let searchButton = UIButton.getButton(image: MSOutlookConstants.BottomStackImages.searchImage)
        let weatherButton = UIButton.getButton(image: MSOutlookConstants.BottomStackImages.mailImage)    
        bottomStackView.addArrangedSubview(calendarButton)
        bottomStackView.addArrangedSubview(searchButton)
        bottomStackView.addArrangedSubview(weatherButton)
    }
    /**
     `setupCalendarHeight` sets up calendar height.
     */
    private func setupCalendarHeight(){
        calendarHeight.constant = CGFloat(MSOutlookConstants.CalendarCellView.calendarCellShrunkHeight)
    }
    /**
     `selectTodaysDate` talks to presenter to update the todays date.
     */
    private func selectTodaysDate() {
        parentPresenter?.selectTodaysDate()
    }
    /**
     `fetchWeatherData` fetches data from `MSOutlookWeatherModelData` and sets the Model into TableviewCell.
     */
    func fetchWeatherData() -> MSOutlookWeatherModelData? {
        return weatherManager.weatherModel
    }
    /**
     `fetchLocationData` fetches data from `MSOutlookLocationModel` and sets the Model into TableviewCell.
     */
    func fetchLocationData() -> MSOutlookLocationModel? {
        return locationModelData
    }
    
}
// MARK: - Conforming MSParentScreenViewProtocol
extension MSParentScreenViewController: MSParentScreenViewProtocol{
    
    func getMonthDescription() -> UILabel? {
        return topViewDescriptionLabel
    }
    
    func fetchCalendarView() -> MSCalendarView? {
        return calendarView
    }
    
    func fetchAgendaView() -> MSAgendaView? {
        return agendaView
    }
    
    func screenActiveViewGetter() -> MSParentScreenActiveView {
        return parentScreenActiveView
    }
    
    func screenActiveViewSetter(withType: MSParentScreenActiveView) {
        parentScreenActiveView = withType
    }
    
    func calendarExpanded() {
        guard parentScreenActiveView != .calendarView else{
            return
        }
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let selfObject = self else{
                return
            }
            selfObject.calendarHeight.constant = CGFloat(MSOutlookConstants.CalendarCellView.calendarCellExpandedHeight)
            selfObject.view.layoutIfNeeded()
        }
    }
    
    func calendarShrunk() {
        guard parentScreenActiveView != .calendarView else{
            return
        }
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let selfObject = self else{
                return
            }
            selfObject.calendarHeight.constant = CGFloat(MSOutlookConstants.CalendarCellView.calendarCellShrunkHeight)
            selfObject.view.layoutIfNeeded()
        }
    }
    
    func fetchDatabase() -> CalendarDatabaseConfiguration.CalendarDatabase? {
        return parentPresenter?.fetchDatabase()
    }
    
}
// MARK: - Set the location manager to self.
extension MSParentScreenViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        guard let lastKnownLocation = locations.last else{
            return
        }
        currentLocation = lastKnownLocation
        weatherManager.fetchWeatherInformation(location: currentLocation.coordinate)
        reverseGeocode(currentLocation: currentLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print(".notDetermined")
            break
            
        case .authorizedAlways:
            print(".authorizedAlways")
           
            break
            
            
        case .denied:
            print(".denied")
            
            break
            
        case .authorizedWhenInUse:
            print(".authorizedWhenInUse")
            
            break
            
        case .restricted:
            print(".restricted")
            break
            
        }
    }
    
}
// MARK: - Conforming WeatherManagerOutputProtocol
extension MSParentScreenViewController: WeatherManagerOutputProtocol{
    /**
     `didFetchWeatherDetailSuccess` executes when the Success block executes for REST API Call and it reloads Tableview data.
     */
    func didFetchWeatherDetailSuccess() {
        DispatchQueue.main.async(execute: {
            self.agendaView?.agendaTableView.reloadData()
        })
    }
    /**
     `didFetchWeatherDetailFailure` executes when the failure block executes for REST API Call and it reloads Tableview data.
     */
    func didFetchWeatherDetailFailure() {
        DispatchQueue.main.async(execute: {
            self.agendaView?.agendaTableView.reloadData()
        })
    }
}
