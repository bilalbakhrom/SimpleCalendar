//
//  CalendarDateConfig.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

open class CalendarDateConfig {
    
    public enum Month: String {
        case january = "01"
        case february = "02"
        case march = "03"
        case april = "04"
        case may = "05"
        case june = "06"
        case july = "07"
        case august = "08"
        case semtember = "09"
        case october = "10"
        case november = "11"
        case december = "12"
    }
    
    private var startDateString: String = "2019-05-01"
    private var startYear: Int = 2019
    
    private var endDateString: String = "2020-01-01"
    private var endYear: Int = 2020
    
    internal var startDate: Date? {
        return CalendarManager.shared.dateFormatter.date(from: startDateString)
    }
    
    internal var endDate: Date? {
        return CalendarManager.shared.dateFormatter.date(from: endDateString)
    }
    
    public func setStartDate(month: Month, year: Int) {
        startYear = year
        startDateString = "\(year)-\(month.rawValue)-01"
    }
    
    public func setEndDate(month: Month, year: Int) {
        endYear = year
        if startYear > endYear {
            fatalError("Start year \(startYear) could not be greater then end year\(endYear)")
        }
        endDateString = "\(year)-\(month.rawValue)-01"
    }

}
