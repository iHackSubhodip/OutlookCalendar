//
//  MSParentScreenRouter.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 This class `MSParentScreenRouter` supports navigation logic. In detail:
 
 - It has all navigation logic for describing which screens are to be shown when.
 */

import Foundation

class MSParentScreenRouter: MSParentScreenRouterProtocol{
    
    // MARK: - instance properties
    weak var parentVC: MSParentScreenViewProtocol?
    
    // MARK: - initialization
    init(view: MSParentScreenViewProtocol?) {
        parentVC = view
    }
    
}
