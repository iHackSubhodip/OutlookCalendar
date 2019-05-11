//
//  MSCalendarFlowlayout.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 02/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 This class `MSCalendarFlowlayout` implements a grid-based Calendar layout. It defines the size of items and the spacing between items in the grid.
 */
import UIKit

final class MSCalendarFlowlayout: UICollectionViewFlowLayout {
    // MARK: - instance properties
    var decorationAttributes: [UICollectionViewLayoutAttributes] = []
    
    // MARK: - init
    override init() {
        super.init()
        register(MSCalendarCellReusableView.self, forDecorationViewOfKind: MSOutlookConstants.CalendarCellView.separatorDecorationView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - layoutAttributesForElements
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect) ?? []
        
        for layoutAttribute in layoutAttributes where layoutAttribute.indexPath.item > 6 {
            let separatorAttribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: MSOutlookConstants.CalendarCellView.separatorDecorationView,
                                                                      with: layoutAttribute.indexPath)
            let cellFrame = layoutAttribute.frame
            separatorAttribute.frame = CGRect(x: cellFrame.origin.x,
                                              y: cellFrame.origin.y,
                                              width: cellFrame.size.width + 2,
                                              height: 0.25)
            separatorAttribute.zIndex = Int.max
            decorationAttributes.append(separatorAttribute)
        }
        
        return layoutAttributes + decorationAttributes
    }
    
}
