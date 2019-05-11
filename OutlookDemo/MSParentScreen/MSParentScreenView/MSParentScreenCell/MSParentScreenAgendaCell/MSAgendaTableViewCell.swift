//
//  MSAgendaTableViewCell.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import UIKit

class MSAgendaTableViewCell: UITableViewCell {
    // MARK: - instance properties
    var agendaModel: AgendaDatabaseConfig.EveryDayAgendaEvents?{
        didSet{
            updateAgendaUI()
        }
    }
    var weatherModel: MSOutlookWeatherModelData?
    var locationModel: MSOutlookLocationModel?
    // MARK: - Meeting Timing Label
    private lazy var meetingTimeLabel: UILabel = {
        let meetingTimeLabel = UILabel()
        meetingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        meetingTimeLabel.textColor = .darkGray
        meetingTimeLabel.font = UIFont.systemFont(ofSize: 12)
        meetingTimeLabel.textAlignment = .left
        meetingTimeLabel.numberOfLines = 1
        return meetingTimeLabel
    }()
    // MARK: - Meeting Duration Label
    private lazy var meetingDurationLabel: UILabel = {
        let meetingDurationLabel = UILabel()
        meetingDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        meetingDurationLabel.textColor = .darkGray
        meetingDurationLabel.font = UIFont.systemFont(ofSize: 12)
        meetingDurationLabel.textAlignment = .left
        meetingDurationLabel.numberOfLines = 1
        return meetingDurationLabel
    }()
    // MARK: - Meeting Country Label
    private lazy var locationCountryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    // MARK: - Meeting Location locality Label
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    // MARK: - Location View
    private lazy var locationView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view //holds [locationCountryLabel, locationLabel]
    }()
    
    // MARK: - Meeting Schedule View
    private lazy var meetingScheduleView: UIView = {
        let meetingScheduleView = UIView()
        meetingScheduleView.translatesAutoresizingMaskIntoConstraints = false
        meetingScheduleView.clipsToBounds = true
        return meetingScheduleView // holds [meetingTimeLabel, meetingDurationLabel]
    }()
    // MARK: - Layout Set up
    private func meetingScheduleViewLayoutSetUp() {
        meetingScheduleView.addSubview(meetingTimeLabel)
        meetingScheduleView.addSubview(meetingDurationLabel)
        
        meetingTimeLabel.anchors(top: meetingScheduleView.topAnchor, topConstants: 6.5, leading: meetingScheduleView.leadingAnchor, leadingConstants: 16, bottom: meetingDurationLabel.topAnchor, bottomConstants: 8, trailing: meetingScheduleView.trailingAnchor, trailingConstants: -8)
        meetingDurationLabel.anchors(leading: meetingTimeLabel.leadingAnchor, bottom: meetingScheduleView.bottomAnchor, bottomConstants: 0, trailing: meetingScheduleView.trailingAnchor, trailingConstants: -8)
    }
    
    private func locationViewSetup() {
        let trailingConstraints: CGFloat = 8.0
        let imageWidthHeight: CGFloat = 20
        locationView.addSubview(locationCountryLabel)
        locationView.addSubview(locationLabel)
        
        locationCountryLabel.anchors(leading: locationView.leadingAnchor, leadingConstants: 16, trailing: locationView.trailingAnchor, trailingConstants: trailingConstraints, heightConstants: imageWidthHeight, centerY: locationView.centerYAnchor, centerYConstants: -10)
        
        locationLabel.anchors(top: locationCountryLabel.bottomAnchor, topConstants: 0, leading: locationView.leadingAnchor, leadingConstants: 16, bottom: locationView.bottomAnchor, bottomConstants: -8, trailing: locationView.trailingAnchor, trailingConstants: trailingConstraints)
    }
    // MARK: - Left Stackview for [meetingScheduleView, locationView]
    private lazy var leftView: UIStackView = {
        let leftView = UIStackView(arrangedSubviews: [meetingScheduleView, locationView])
        leftView.axis = .vertical
        leftView.spacing = 8
        leftView.distribution = .fillEqually
        leftView.translatesAutoresizingMaskIntoConstraints = false
        return leftView
    }()
    
    // MARK: - meeting TitleLabel
    private lazy var meetingTitleLabel: UILabel = {
        let eventTitleLabel = UILabel()
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTitleLabel.textAlignment = .left
        eventTitleLabel.textColor = .black
        eventTitleLabel.font = UIFont.systemFont(ofSize: 12)
        eventTitleLabel.numberOfLines = 2
        eventTitleLabel.lineBreakMode = .byTruncatingTail
        return eventTitleLabel
    }()
    // MARK: - meeting Attendees Stackview
    private lazy var meetingPepoleStackView: UIStackView = {
        let meetingPepoleStackView = UIStackView()
        meetingPepoleStackView.distribution = .fillEqually
        meetingPepoleStackView.spacing = 4
        meetingPepoleStackView.translatesAutoresizingMaskIntoConstraints = false
        meetingPepoleStackView.axis = .horizontal
        return meetingPepoleStackView
    }()
    // MARK: - meeting Location Weather Image
    private lazy var meetingLocationImage: UIImageView = {
        let meetingLocationImage = UIImageView()
        meetingLocationImage.translatesAutoresizingMaskIntoConstraints = false
        return meetingLocationImage
    }()
    // MARK: - meeting Location Weather label
    private lazy var meetingLocationWeather: UILabel = {
        let meetingLocationWeather = UILabel()
        meetingLocationWeather.translatesAutoresizingMaskIntoConstraints = false
        meetingLocationWeather.textColor = .darkGray
        meetingLocationWeather.numberOfLines = 2
        meetingLocationWeather.font = UIFont.systemFont(ofSize: 12)
        meetingLocationWeather.textAlignment = .left
        return meetingLocationWeather
    }()
    // MARK: - meeting Location View
    private lazy var meetingLocationView: UIView = {
        let meetingLocationView = UIView()
        meetingLocationView.translatesAutoresizingMaskIntoConstraints = false
        meetingLocationView.clipsToBounds = true
        return meetingLocationView // holds [meetingLocationWeather, meetingLocationImage]
    }()
    // MARK: - Layout setup for Meeting
    private func meetingLocationViewSetup() {
        meetingLocationView.addSubview(meetingLocationWeather)
        meetingLocationView.addSubview(meetingLocationImage)
        
        meetingLocationWeather.anchors(leading: meetingLocationImage.trailingAnchor, leadingConstants: 4, trailing: meetingLocationView.trailingAnchor, trailingConstants: -8, centerY: meetingLocationImage.centerYAnchor)
        
        meetingLocationImage.anchors(leading: meetingLocationView.leadingAnchor, leadingConstants: 0, heightConstants: 18, widthConstants: 18, centerY: meetingLocationView.centerYAnchor, centerYConstants: 0)
    }
    // MARK: - Right Stack view
    private lazy var rightView: UIStackView = {
        let rightView = UIStackView(arrangedSubviews: [meetingTitleLabel, meetingPepoleStackView, meetingLocationView])
        rightView.axis = .vertical
        rightView.spacing = 8
        rightView.distribution = .fillEqually
        rightView.translatesAutoresizingMaskIntoConstraints = false
        return rightView
    }()
    // MARK: - color Image View
    private lazy var colorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .purple
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView//kind of seperator for left and right stack
    }()
    // MARK: - Image view setup
    private func imageViewLayoutSetup() {
        addSubview(colorImageView)
        colorImageView.anchors(top: topAnchor, topConstants: 10, leading: leftView.trailingAnchor, leadingConstants: 0, trailing: rightView.leadingAnchor, trailingConstants: -16, heightConstants: 10, widthConstants: 10)
    }
    // MARK: - Left & Right Stack view Anchoring
    private func leftStackViewAnchoring() {
        addSubview(leftView)
        leftView.anchors(top: topAnchor, leading: leadingAnchor, heightConstants: 100, widthConstants: 100)
    }
    private func rightStackViewAnchoring() {
        addSubview(rightView)
        rightView.anchors(top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, heightConstants: 100)
    }
    /**
     This function `cellLayoutSetup()` used for setting up `MSAgendaTableViewCell`.
     */
    private func cellLayoutSetup(){
        meetingScheduleViewLayoutSetUp()
        locationViewSetup()
        meetingLocationViewSetup()
        leftStackViewAnchoring()
        rightStackViewAnchoring()
        imageViewLayoutSetup()
    }
    /**
     This function `updateAgendaUI()` gets model from the tableview and Update `MSAgendaTableViewCell` UI.
     */
    private func updateAgendaUI(){
        guard let agendaModel = agendaModel else{
            return
        }
        meetingTitleLabel.text = agendaModel.title
        meetingTimeLabel.text = "\(DateFormatter().getHoursMinutes(date: agendaModel.startTime))"
        meetingDurationLabel.text = "30m"
        setupMeetingPepoleStackView()
        showWeatherInfo()
        showLocationinfo()
    }
    /**
     This function `showLocationinfo()` gets `locationModel` from the tableview and Update `MSAgendaTableViewCell` Location UI.
     */
    private func showLocationinfo(){
        guard let model = locationModel else{
            locationLabel.text = MSOutlookConstants.emptyLocation
            locationCountryLabel.text = MSOutlookConstants.emptyLocation
            return
        }
        if (model.localityName != "XYZ"){
            locationCountryLabel.text = "\(model.localityName),"
            locationLabel.text = "\(model.countryName)."
        }
    }
    /**
     This function `showWeatherInfo()` gets `weatherModel` & `agendaModel` from the tableview and Update `MSAgendaTableViewCell` Weather UI.
     */
    private func showWeatherInfo() {
        guard let model = agendaModel, let weatherData = weatherModel else {
            return
        }
        if weatherData.dataRetrived{
            let date = model.date
            let fromDate = weatherData.firstDate
            let toDate = weatherData.lastDate
            
            if (fromDate.compare(date) == ComparisonResult.orderedAscending && date.compare(toDate) == ComparisonResult.orderedAscending) ||
                fromDate.compare(date) == ComparisonResult.orderedSame || toDate.compare(date) == ComparisonResult.orderedSame {
                let icon = weatherData.weatherData[date]?.icon ?? MSOutlookConstants.WeatherIcon.clearDay
                meetingLocationImage.image = UIImage(named: icon)
                let summary = weatherData.weatherData[date]?.summary ?? MSOutlookConstants.defaultWeather
                meetingLocationWeather.text = summary
            } else {
                meetingLocationImage.image = UIImage(named: MSOutlookConstants.WeatherIcon.clearDay)
                meetingLocationWeather.text = MSOutlookConstants.defaultWeather
            }
        }else{
            meetingLocationWeather.text = MSOutlookConstants.failedData
            meetingLocationImage.image = #imageLiteral(resourceName: "error")
        }
    }
    /**
     This function `setupMeetingPepoleStackView()` gets `agendaModel` from the cell and Update `MSAgendaTableViewCell` Meeting Attendees UI Details.
     */
    private func setupMeetingPepoleStackView() {
        guard let agendaModel = agendaModel, agendaModel.meetingPeople.count > 0, meetingPepoleStackView.arrangedSubviews.count < 6 else { return }
        let peopleCount = agendaModel.meetingPeople.count
        let imagesCount = peopleCount >= 4 ? 4 : peopleCount
        for i in 0...imagesCount-1 {
            let combinedName = agendaModel.meetingPeople[i].combinedName
            let label = UILabel.getTextLabel(dayValue: combinedName)
            label.backgroundColor = UIColor(hexString: agendaModel.meetingPeople[i].backgroundColor)
            label.textColor = .white
            label.layer.cornerRadius = 11
            label.layer.masksToBounds = true
            meetingPepoleStackView.addArrangedSubview(label)
        }
        meetingPepoleStackView.addArrangedSubview(UIView())
        meetingPepoleStackView.addArrangedSubview(UIView())
        if imagesCount < 4 {
            for _ in 0..<4-imagesCount {
                meetingPepoleStackView.addArrangedSubview(UIView())
            }
        }
    }
    // MARK: - initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellLayoutSetup()
    }
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        meetingTitleLabel.text = MSOutlookConstants.emptyString
        meetingTimeLabel.text = MSOutlookConstants.emptyString
        meetingDurationLabel.text = MSOutlookConstants.emptyString
        meetingLocationWeather.text = MSOutlookConstants.emptyLocation
        meetingLocationImage.image = UIImage()
        locationLabel.text = MSOutlookConstants.emptyLocation
        locationCountryLabel.text = MSOutlookConstants.emptyLocation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
