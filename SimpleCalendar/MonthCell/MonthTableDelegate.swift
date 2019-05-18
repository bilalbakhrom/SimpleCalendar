//
//  MonthTableDelegate.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 18/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal protocol MonthTableDelegate: class {
    func monthTable(selectedDates dates: [Date])
    func monthTable(deselectedDate date: Date)
}
