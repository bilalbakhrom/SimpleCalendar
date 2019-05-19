//
//  MonthDataContainer.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import Foundation

internal class MonthDataContainer {
    
    internal var startDate: Date?
    
    internal var lastDay: Int = 0
    
    internal var firstWeekDay: Int = 0
    
    internal var monthSymbol: String?
    
    internal var year: String?
    
    internal var header: String {
        return "\(monthSymbol ?? "") \(year ?? "")"
    }
    
    internal var components: [ComponentModel] = []
}
