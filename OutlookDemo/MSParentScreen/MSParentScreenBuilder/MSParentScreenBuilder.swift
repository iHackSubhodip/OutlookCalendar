//
//  MSParentScreenBuilder.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 ## Feature Support
 
 This structure `MSParentScreenBuilder` consturcts VIPER wireframe. In detail:
 
 - It creates the VIPER module and returns the `MSParentScreenViewController`.
 - View has strong reference of presenter
 - Presenter has strong reference of Interactor, weak reference of View.
 - Interactor has strong reference of Router, weak reference of Presenter
 - Router has weak reference of view. Builder just builds the initial VIPER module.
 */
import UIKit

struct MSParentScreenBuilder: MSParentScreenBuilderProtocol{
    /**
     This function creates the VIPER module and returns the `MSParentScreenViewController`.
     - returns: It will return `MSParentScreenViewController`.
     */
    func parentScreenBuilder() -> MSParentScreenViewController? {
        guard let parentScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MSParentScreenVC") as? MSParentScreenViewController else{
            return nil
        }
        let parentScreenPresenter = MSParentScreenPresenter(view: parentScreenVC)
        let parentScreenRouter = MSParentScreenRouter(view: parentScreenVC)
        let parentScreenInteractor = MSParentScreenInteractor(router: parentScreenRouter, presenter: parentScreenPresenter)
        parentScreenVC.parentPresenter = parentScreenPresenter
        parentScreenPresenter.parentScreenInteractor = parentScreenInteractor
        return parentScreenVC
    }
}
