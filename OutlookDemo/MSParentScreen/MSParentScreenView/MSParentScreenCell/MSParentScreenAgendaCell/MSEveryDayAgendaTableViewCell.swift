//
//  MSEveryDayAgendaTableViewCell.swift
//  OutlookDemo
//
//  Created by Banerjee, Subhodip on 11/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import UIKit

class MSEveryDayAgendaTableViewCell: UITableViewCell {
    // MARK: - instance properties
    var everyDayAgendaModel: AgendaDatabaseConfig.EveryDayAgendaEvents?{
        didSet{
            updateEveryDayAgendaUI()
        }
    }
    // MARK: - every Day Agenda Label
    private lazy var everyDayAgendaLabel: UILabel = {
        let everyDayAgendaLabel = UILabel()
        everyDayAgendaLabel.translatesAutoresizingMaskIntoConstraints = false
        everyDayAgendaLabel.textAlignment = .left
        everyDayAgendaLabel.font = UIFont.systemFont(ofSize: 12)
        everyDayAgendaLabel.textColor = .black
        everyDayAgendaLabel.numberOfLines = 1
        return everyDayAgendaLabel
    }()
    // MARK: - every Day Agenda Title
    private lazy var everyDayAgendaTitle: UILabel = {
        let everyDayAgendaTitle = UILabel()
        everyDayAgendaTitle.translatesAutoresizingMaskIntoConstraints = false
        everyDayAgendaTitle.textAlignment = .left
        everyDayAgendaTitle.font = UIFont.systemFont(ofSize: 12)
        everyDayAgendaTitle.textColor = .black
        everyDayAgendaTitle.numberOfLines = 1
        return everyDayAgendaTitle
    }()
    // MARK: - every Day Agenda Image
    private lazy var everyDayAgendaImage: UIImageView = {
        let everyDayAgendaImage = UIImageView()
        everyDayAgendaImage.translatesAutoresizingMaskIntoConstraints = false
        everyDayAgendaImage.layer.cornerRadius = 5.0
        everyDayAgendaImage.layer.masksToBounds = true
        everyDayAgendaImage.backgroundColor = .green
        everyDayAgendaImage.contentMode = .scaleAspectFit
        return everyDayAgendaImage
    }()
    /**
     This function `updateEveryDayAgendaUI()` gets the model from tableview and updates `MSEveryDayAgendaTableViewCell`.
     */
    private func updateEveryDayAgendaUI(){
        everyDayAgendaLabel.text = MSOutlookConstants.EveryDayAgendaCellView.everyDayAgendaCellLabel
        everyDayAgendaTitle.text = everyDayAgendaModel?.title ?? MSOutlookConstants.MSOutlookManagerConstants.everyDayAgendaEvent
    }
    /**
     This function `everyDayAgendaCellSetup()` add subview for all the labels in the cell.
     */
    private func everyDayAgendaCellSetup(){
        addSubview(everyDayAgendaTitle)
        addSubview(everyDayAgendaLabel)
        addSubview(everyDayAgendaImage)
    }
    /**
     This function `everyDayAgendaCellLayoutSetup()` sets the anchors for the lables in the cell.
     */
    private func everyDayAgendaCellLayoutSetup(){
        everyDayAgendaLabel.anchors(leading: leadingAnchor, leadingConstants: 16, trailing: everyDayAgendaImage.leadingAnchor, trailingConstants: 0, widthConstants: 84, centerY: centerYAnchor)
        everyDayAgendaImage.anchors(trailing: everyDayAgendaTitle.leadingAnchor, trailingConstants: -16, heightConstants: 10, widthConstants: 10, centerY: centerYAnchor)
        everyDayAgendaTitle.anchors(trailing: trailingAnchor, trailingConstants: -16, centerY: centerYAnchor)
    }
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        everyDayAgendaLabel.text = MSOutlookConstants.emptyString
        everyDayAgendaTitle.text = MSOutlookConstants.emptyString
    }
    // MARK: - initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        everyDayAgendaCellSetup()
    }
    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        everyDayAgendaCellLayoutSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
