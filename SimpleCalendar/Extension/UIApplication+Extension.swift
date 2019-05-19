//
//  UIApplication+Extension.swift
//  SimpleCalendar
//
//  Created by Bilal Bakhrom on 20/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal extension UIApplication {
    
    func setStatusViewBackgroundColor(_ color: UIColor?) {
        guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
            return
        }
        statusBarView.backgroundColor = color
    }
}
