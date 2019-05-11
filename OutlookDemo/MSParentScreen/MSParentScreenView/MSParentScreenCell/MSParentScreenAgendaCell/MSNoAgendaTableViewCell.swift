//
//  MSNoAgendaTableViewCell.swift
//  OutlookDemo
//
//  Created by Banerjee, Subhodip on 11/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import UIKit

class MSNoAgendaTableViewCell: UITableViewCell {
    // MARK: - no Agenda Label
    private let noAgendaLabel: UILabel = {
        let noAgendaLabel = UILabel()
        noAgendaLabel.translatesAutoresizingMaskIntoConstraints = false
        noAgendaLabel.text = MSOutlookConstants.NoAgendaCellView.noAgendaCellLabel
        noAgendaLabel.font = UIFont.systemFont(ofSize: 14)
        noAgendaLabel.textColor = .lightGray
        noAgendaLabel.textAlignment = .left
        noAgendaLabel.numberOfLines = 1
        return noAgendaLabel
    }()
    /**
     This function `noAgendaCellSetup()` add subview for `noAgendaLabel`.
     */
    private func noAgendaCellSetup(){
        addSubview(noAgendaLabel)
    }
    /**
     This function `noAgendaCellLayoutSetup()` sets anchor for `noAgendaLabel`.
     */
    private func noAgendaCellLayoutSetup(){
        noAgendaLabel.anchors(leading: leadingAnchor, leadingConstants: 16.0, trailing: trailingAnchor, trailingConstants: -8, heightConstants: 44, centerY: centerYAnchor, centerYConstants: 0.0)
    }
    // MARK: - initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        noAgendaCellSetup()
    }
    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        noAgendaCellLayoutSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
