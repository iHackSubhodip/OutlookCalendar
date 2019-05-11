//
//  MSExtensions.swift
//  OutlookDemo
//
//  Created by Subhodip Banerjee on 18/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//

/**
 This extensions contains all the methods, which are required to be extended. Following are the classes which are used in the application:
 - UIButton
 - UILabel
 - UIView
 - UIColor
 - UICollectionView
 */

import UIKit

public extension UIButton{
    /**
     This function `getButton` set images[picked from Application assets] for a given button.
     - parameter image: We are passing `image`[`String`] in String format[picked from Application assets].
     - returns: It will return `UIButton`, which will be in the form of `Button` with `UIImage`.
     */
    static func getButton(image: String) -> UIButton{
        let button = UIButton(type: .system)
        let image = UIImage(named: image)
        button.setImage(image, for: .normal)
        button.contentMode = .center
        button.frame = CGRect.zero
        return button
    }
    
}

public extension UILabel{
    /**
     This function `getTextLabel` gets the text label which can be assigned to a `UILabel`.
     - parameter dayValue: We are passing `dayValue`[`String`] in String format.
     - returns: It will return in `UILabel` format from the given `dayValue`[`String`].
     */
    static func getTextLabel(dayValue: String) -> UILabel{
        let label = UILabel()
        label.text = dayValue
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.frame = CGRect.zero
        return label
    }
    
}

public extension UIView {
    /**
     This function `anchors` sets the anchor of a particular UIView.
     */
    func anchors(top: NSLayoutYAxisAnchor? = nil, topConstants: CGFloat = 0.0, leading: NSLayoutXAxisAnchor? = nil, leadingConstants: CGFloat = 0.0, bottom: NSLayoutYAxisAnchor? = nil, bottomConstants: CGFloat = 0.0, trailing: NSLayoutXAxisAnchor? = nil, trailingConstants: CGFloat = 0.0, heightConstants: CGFloat = 0.0, widthConstants: CGFloat = 0.0, centerX: NSLayoutXAxisAnchor? = nil, centerXConstants: CGFloat = 0.0, centerY: NSLayoutYAxisAnchor? = nil, centerYConstants: CGFloat = 0.0 ) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstants).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: leadingConstants).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstants).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: trailingConstants).isActive = true
        }
        if heightConstants > 0 {
            heightAnchor.constraint(equalToConstant: heightConstants).isActive = true
        }
        if widthConstants > 0 {
            widthAnchor.constraint(equalToConstant: widthConstants).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: centerXConstants).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: centerYConstants).isActive = true
        }
    }
}

public extension UIColor {
    /**
     This function lets you create colors from hex strings.
     - parameter hexString: We are passing `hexString`[`String`] in String format, It should be a # symbol, followed by red, green, blue and alpha in hex format, for a total of nine characters. e.g., #ffe700ff is gold.
     - returns: The method is a failable initializer, which means it returns nil if you don't specify a color in the correct format.
     */
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

extension UICollectionView {
    /**
     This function `isIndexPathAvailable` gets if current `indexpath` is available or not.
     - parameter indexPath: We are passing `indexPath`[`IndexPath`] in String format.
     - returns: It will return in `Bool` format, it will return `true` if current `indexpath` is available, else it will return false.
     */
    func isIndexPathAvailable(_ indexPath: IndexPath) -> Bool {
        guard dataSource != nil,
            indexPath.section < numberOfSections,
            indexPath.item < numberOfItems(inSection: indexPath.section) else {
                return false
        }
        
        return true
    }
}
