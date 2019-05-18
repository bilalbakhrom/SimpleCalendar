//
//  UIViewController+Extension.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 18/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal extension UIViewController {
    
    func addSubview(_ subview: UIView) {
        view.addSubview(subview)
    }
    
    var isPushed: Bool {
        return navigationController != nil
    }
    
    var isPresented: Bool {
        return presentingViewController != nil
    }
    
}

