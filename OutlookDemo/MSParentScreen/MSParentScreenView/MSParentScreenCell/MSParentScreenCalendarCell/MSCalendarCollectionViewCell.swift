//
//  MSCalendarCollectionViewCell.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

import UIKit

class MSCalendarCollectionViewCell: UICollectionViewCell {
    // MARK: - cell Month Label
    let cellMonthLabel: UILabel = {
        let cellMonthLabel = UILabel()
        cellMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        cellMonthLabel.textAlignment = .center
        cellMonthLabel.textColor = .darkGray
        cellMonthLabel.font = UIFont.systemFont(ofSize: 8)
        cellMonthLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        cellMonthLabel.contentHuggingPriority(for: .vertical)
        return cellMonthLabel
    }()
    // MARK: - cell Date Label
    let cellDateLabel: UILabel = {
        let cellDateLabel = UILabel()
        cellDateLabel.translatesAutoresizingMaskIntoConstraints = false
        cellDateLabel.textAlignment = .center
        cellDateLabel.textColor = .darkGray
        cellDateLabel.font = UIFont.systemFont(ofSize: 12)
        return cellDateLabel
    }()
    
    // MARK: - cell Dotted ImageView
    let cellDottedImageView: UIImageView = {
        let cellDottedImageView = UIImageView()
        cellDottedImageView.translatesAutoresizingMaskIntoConstraints = false
        cellDottedImageView.backgroundColor = .lightGray
        cellDottedImageView.isHidden = true
        cellDottedImageView.layer.cornerRadius = 2.5
        cellDottedImageView.clipsToBounds = true
        cellDottedImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        cellDottedImageView.contentHuggingPriority(for: .vertical)
        return cellDottedImageView
    }()
    // MARK: - instance properties
    var cellModel: MSOutlookCalendarCellModel? {
        didSet{
            updateModelData()// updates calendar model.
        }
    }
    //`isSelected` determines if the cell is selected or not.
    override var isSelected: Bool {
        get {
            return super.isSelected;
        }
        set {
            if (super.isSelected != newValue) {
                super.isSelected = newValue
                if (newValue == true) {
                    selectedBackgroundView = UIView(frame: bounds)
                    selectedBackgroundView?.frame = CGRect(x: 10, y: 5, width: frame.size.width * 0.7, height: frame.size.height * 0.7)
                    selectedBackgroundView?.layer.cornerRadius = frame.size.width / 3.0
                    selectedBackgroundView?.layer.borderColor = UIColor.clear.cgColor
                    selectedBackgroundView?.layer.masksToBounds = true
                    selectedBackgroundView?.backgroundColor = UIColor(displayP3Red: 30.0/255.0, green: 144.0/255.0, blue: 1.0, alpha: 0.5)
                    cellDateLabel.textColor = .white
                    cellMonthLabel.textColor = .white
                    cellDottedImageView.backgroundColor = .white
                } else {
                    selectedBackgroundView?.backgroundColor = .clear
                    cellDateLabel.textColor = .darkGray
                    cellMonthLabel.textColor = .darkGray
                    cellDottedImageView.backgroundColor = .lightGray
                }
            }
        }
    }
    /**
     This function `updateModelData()` get `cellModel` data and update UI.
     */
    private func updateModelData(){
        guard let cellModel = cellModel else {
            return
        }
        cellDateLabel.text = cellModel.dateString
        cellDottedImageView.isHidden = !cellModel.isDottedDate
        cellMonthLabel.text = !cellModel.monthString.isEmpty ?  cellModel.monthString  : MSOutlookConstants.emptyString
        isSelected = false
        if cellModel.checkCurrentDate{
            layer.borderWidth = 0.5
            layer.cornerRadius = 5.0
            layer.borderColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        }
    }
    /**
     This function `setupLayoutCell()` adds anchor to the cell elements.
     */
    private func setupLayoutCell(){
        NSLayoutConstraint.activate([
            cellMonthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            cellMonthLabel.bottomAnchor.constraint(equalTo: cellDateLabel.topAnchor, constant: -3.0),
            cellMonthLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            cellDateLabel.bottomAnchor.constraint(equalTo: cellDottedImageView.topAnchor, constant: 1.0),
            cellDateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            cellDottedImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -frame.size.height * 0.3),
            cellDottedImageView.heightAnchor.constraint(equalToConstant: 5.0),
            cellDottedImageView.widthAnchor.constraint(equalToConstant: 5.0),
            cellDottedImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    /**
     This function `setupCollectionViewCell()` sets up collectionview cell.
     */
    private func setupCollectionViewCell(){
        
        backgroundColor = .white
        layer.cornerRadius = frame.size.width / 2.0
        addSubview(cellMonthLabel)
        addSubview(cellDateLabel)
        addSubview(cellDottedImageView)
    }
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewCell()
    }
    // MARK: - layoutSubviews
    override func layoutSubviews() {
        
        super.layoutSubviews()
        setupLayoutCell() // Anchor setup
    }
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        reuseCollectionViewCell()
    }
    private func reuseCollectionViewCell(){
        cellDateLabel.text = MSOutlookConstants.emptyString
        cellMonthLabel.text = MSOutlookConstants.emptyString
        cellDottedImageView.isHidden = true
        isSelected = false
        cellDateLabel.textColor = .darkGray
        cellMonthLabel.textColor = .darkGray
        cellDottedImageView.backgroundColor = .lightGray
        selectedBackgroundView?.backgroundColor = .clear
        selectedBackgroundView?.layer.cornerRadius = 0.0
        layer.borderWidth = 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
