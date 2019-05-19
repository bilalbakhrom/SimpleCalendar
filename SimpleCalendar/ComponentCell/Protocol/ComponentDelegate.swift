//
//  ComponentDelegate.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 18/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal protocol ComponentDelegate: class {
    func component(isSelected: Bool, date: Date)    
}
