//
//  SimpleCalendarDelegate.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 18/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

public protocol SimpleCalendarDelegate: class {
    /**
     Tells the delegate selected dates
     
     - Important: Date format: yyyy-mm-dd
     */
    func simpleCalendar(selectedDates dates: [Date])
    
    /// Gets selected dates
    func simpleCalendar() -> [Date]
}

extension SimpleCalendarDelegate {
    
    func simpleCalendar() -> [Date] {
        return []
    }
    
}
