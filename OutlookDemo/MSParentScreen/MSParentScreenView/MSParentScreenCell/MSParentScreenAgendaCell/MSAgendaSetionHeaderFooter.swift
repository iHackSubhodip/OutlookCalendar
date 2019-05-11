//
//  MSAgendaSetionHeaderFooter.swift
//  OutlookDemo
//
//  Created by Banerjee, Subhodip on 11/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import UIKit

class MSAgendaSetionHeaderFooter: UITableViewHeaderFooterView {
    // MARK: - instance properties
    var sectionTitle: String? {
        didSet {
            sectionHeaderLabel.text = sectionTitle ?? ""
        }
    }
    var sectionTitleTextColor: UIColor?{
        didSet{
            sectionHeaderLabel.textColor = sectionTitleTextColor
        }
    }
    // MARK: - instance properties
    private let sectionHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    /**
     This function `layoutSetup()` add subview for all the labels in the cell.
     */
    private func layoutSetup() {
        addSubview(sectionHeaderLabel)
    }
    /**
     This function `layoutConstraintSetup()` sets the anchors for the lables in the cell.
     */
    private func layoutConstraintSetup() {
        sectionHeaderLabel.anchors(top: topAnchor, leading: leadingAnchor, leadingConstants: 16.0, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    // MARK: - initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layoutSetup()
    }
    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutConstraintSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
