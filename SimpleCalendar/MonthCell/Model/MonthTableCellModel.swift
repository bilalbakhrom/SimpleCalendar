//
//  MonthTableCellModel.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal class MonthTableCellModel {
    
    internal var selectedDatesDictionary: [String:Date] = [:]
 
    internal func getSelectedDates() -> [Date] {
        var all: [Date] = []
        for element in selectedDatesDictionary {
            all.append(element.value)
        }        
        return all
    }
    
}
