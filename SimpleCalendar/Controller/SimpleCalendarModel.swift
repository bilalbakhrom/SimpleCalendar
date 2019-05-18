//
//  SimpleCalendarModel.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit


internal class SimpleCalendarModel {
    
    internal var monthContainers: [MonthDataContainer] = []
    
    internal var selectedDatesDictionary: [String:Date] = [:]
    
    internal func getSelectedDates() -> [Date] {
        var all: [Date] = []
        for element in selectedDatesDictionary {
            all.append(element.value)
        }
        return all
    }
    
    internal func updateComponents(withSelectedDates dates: [Date]) {
        dates.forEach { (date) in
            monthContainers.forEach({ (container) in
                container.components.forEach({ (component) in
                    if CalendarManager.shared.isSame(firstDate: date, secondDate: component.date) {
                        component.isSelected = true
                    }
                })
            })
        }
    }
    
    internal func configure(with config: CalendarConfig) {
        monthContainers.removeAll()
        let allMonths = CalendarManager.shared.allMonths(from: config.dateConfig.startDate,
                                                     to: config.dateConfig.endDate)
        
        for date in allMonths {
            let container = MonthDataContainer()
            container.startDate = date
            container.lastDay = CalendarManager.shared.lastDay(of: date)
            container.firstWeekDay = CalendarManager.shared.firstWeekDay(of: date)
            container.monthSymbol = CalendarManager.shared.monthSymbol(for: date).uppercased()
            container.year = CalendarManager.shared.year(for: date).str
            container.components = getComponents(for: container)
            monthContainers.append(container)
        }
        
    }
    
    private func getComponents(for container: MonthDataContainer) -> [ComponentModel] {
        var components: [ComponentModel] = []
        
        /// Set weekdays
        for weekdaySymbol in CalendarManager.shared.weekdaySymbols() {
            let component = ComponentModel(state: .weekday)
            component.weekdaySymbol = weekdaySymbol.uppercased()
            components.append(component)
        }
        
        /// Set empty cells
        let emptyCellCount = container.firstWeekDay
        for _ in 0..<emptyCellCount {
            components.append(ComponentModel(state: .none))
        }
        
        /// Set days
        for day in 1...container.lastDay {
            let component = ComponentModel(state: .day)
            component.day = day
            component.date = CalendarManager.shared.date(byAdddingValue: day-1, to: container.startDate!)
            component.isOutOfDate = CalendarManager.shared.isOutOfDate(component.date)
            components.append(component)
        }
        
        return components
    }
    
}
