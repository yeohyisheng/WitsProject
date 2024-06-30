//
//  UIColor.swift
//  WitsProject
//
//  Created by yeoh on 28/06/2024.
//

import Foundation
import UIKit
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}
