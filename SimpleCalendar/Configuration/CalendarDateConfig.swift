//
//  CalendarDateConfig.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

open class CalendarDateConfig {
    
    public enum Month: Int {
        case january = 1
        case february
        case march
        case april
        case may
        case june
        case july
        case august
        case semtember
        case october
        case november
        case december
        
        internal func getStringFormat() -> String {
            switch self {
            case .january: return "01"
            case .february: return "02"
            case .march: return "03"
            case .april: return "04"
            case .may: return "05"
            case .june: return "06"
            case .july: return "07"
            case .august: return "08"
            case .semtember: return "09"
            case .october: return "10"
            case .november: return "11"
            case .december: return "12"
            }
        }
    }
    
    private var startDateString: String = "2019-01-01"
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
        startDateString = "\(year)-\(month.getStringFormat())-01"
    }
    
    public func setEndDate(month: Month, year: Int) {
        endYear = year
        if startYear > endYear {
            fatalError("Start year \(startYear) could not be greater then end year\(endYear)")
        }
        endDateString = "\(year)-\(month.getStringFormat())-01"
    }

}
