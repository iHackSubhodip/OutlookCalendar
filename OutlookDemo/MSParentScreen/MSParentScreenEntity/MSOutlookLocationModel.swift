//
//  MSOutlookLocationModel.swift
//  OutlookDemo
//
//  Created by Banerjee, Subhodip on 29/03/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 - This Entity contains all the models for `CurrentLocation`.
 */
import Foundation
/**
 `MSOutlookLocationModel` defines current location data.
 - `countryName: String` - country Name for current location data.
 - `localityName: String` - locality Name for current location data.
 */
struct MSOutlookLocationModel {
    let countryName: String
    let localityName: String
}
