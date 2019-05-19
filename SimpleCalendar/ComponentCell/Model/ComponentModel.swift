//
//  ComponentModel.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal class ComponentModel {
    
    internal enum CellState {
        case weekday
        case day
        case none
    }
    
    internal weak var componentDelegate: ComponentDelegate?
    
    internal var isSelected: Bool = false {
        didSet {
            componentDelegate?.component(isSelected: self.isSelected, date: date!)
        }
    }
    
    internal let state: CellState

    internal var weekdaySymbol: String?
    
    internal var day: Int?
    
    internal var date: Date?
    
    internal var isOutOfDate = false
    
    init(state: CellState) {
        self.state = state
    }
    
}
