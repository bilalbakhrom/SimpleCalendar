//
//  UIView+Extension.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal extension UIView {
    
    func endEditingOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureHandler))
        addGestureRecognizer(gesture)
    }
    
    @objc private func gestureHandler(_ gesture: UITapGestureRecognizer) {
        endEditing(true)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    var compatibleSafeArea: UILayoutGuide {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide
        } else {
            if let layoutGuide = self.associatedLayoutGuide {
                return layoutGuide
            } else {
                let standardTopSpacing: CGFloat = 10.0
                let layoutGuide = UILayoutGuide()
                addLayoutGuide(layoutGuide)
                
                NSLayoutConstraint.activate([
                    layoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: standardTopSpacing),
                    layoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
                    layoutGuide.leftAnchor.constraint(equalTo: leftAnchor),
                    layoutGuide.rightAnchor.constraint(equalTo: rightAnchor)
                    ])
                
                self.associatedLayoutGuide = layoutGuide
                return layoutGuide
            }
        }
    }
    
    private struct AssociatedKeys {
        static var layoutGuide = "layoutGuide"
    }
    
    fileprivate var associatedLayoutGuide: UILayoutGuide? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.layoutGuide) as? UILayoutGuide
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self, &AssociatedKeys.layoutGuide,
                    newValue as UILayoutGuide?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
