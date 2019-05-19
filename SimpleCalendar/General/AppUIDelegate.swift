//
//  AppUIDelegate.swift
//  SimpleCalendar
//
//  Created by Bilal Bakhrom on 20/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal protocol AppUIDelegate: class {
    func setupUI(for view: UIView)
    func addSubviews(into view: UIView)
    func setSubviewsConstraints(for view: UIView)
}
