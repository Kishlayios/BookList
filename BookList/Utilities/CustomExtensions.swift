//
//  CustomExtensions.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import UIKit

extension UIView {
    /**
     Set a shadow on a UIView.
     - parameters:
     - color: Shadow color, defaults to black
     - opacity: Shadow opacity, defaults to 1.0
     - offset: Shadow offset, defaults to zero
     - radius: Shadow radius, defaults to 0
     - viewCornerRadius: If the UIView has a corner radius this must be set to match
     */
    func setShadowWithColor(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat, viewCornerRadius: CGFloat?) {
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius
        layer.cornerRadius = viewCornerRadius ?? 0
    }
}
