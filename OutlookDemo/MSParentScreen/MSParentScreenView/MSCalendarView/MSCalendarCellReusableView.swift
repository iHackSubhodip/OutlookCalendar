//
//  MSCalendarCellReusableView.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 03/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support

 This class `MSCalendarCellReusableView` defines the behavior for all Collectionviewcells.
 
 -It's ReusableView because the collection view places them on a reuse queue rather than deleting them when they are scrolled out of the visible bounds.
 */
import UIKit

final class MSCalendarCellReusableView: UICollectionReusableView {
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Apply
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        frame = layoutAttributes.frame
    }
}
