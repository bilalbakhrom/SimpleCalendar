//
//  CalendarManager.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal class CalendarManager {
    
    internal static let shared = CalendarManager()
    
    internal var locale: Locale? = Locale(identifier: "en-Us")
    
    internal var selectionLimit = 0
    
    internal var numberOfSelectedCells = 0
    
    internal var isLimitReached: Bool {
        if selectionLimit == 0 {
            return false
        }        
        return numberOfSelectedCells >= selectionLimit
    }
    
    private let calendar = Calendar.current
    
    enum Weekday: Int {
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        
        func actualday() -> Int {
            switch self {
            case .monday: return 0
            case .tuesday: return 1
            case .wednesday: return 2
            case .thursday: return 3
            case .friday: return 4
            case .saturday: return 5
            case .sunday: return 6
            }
        }
    }
    
    private init() {}
    
    internal func date(byAdddingValue value: Int, to date: Date) -> Date? {
        return calendar.date(byAdding: .day, value: value, to: date)
    }
    
    internal let dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        format.locale = Locale(identifier: "en_US_POSIX")
        format.timeZone = TimeZone(secondsFromGMT: 0)
        return format
    }()
    
    internal func lastDay(of date: Date?) -> Int {
        guard let date = date else { return 0}
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: date)
        let currentMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth!)
        let lastday = calendar.component(.day, from: currentMonth!)
        return lastday
    }
    
    internal func firstWeekDay(of date: Date?) -> Int {
        guard let date = date else { return -1 }
        let weekday = calendar.component(.weekday, from: date)
        guard let w = Weekday(rawValue: weekday) else { return -1}
        return w.actualday()        
    }
    
    internal func allMonths(from startDate: Date?, to endDate: Date?) -> [Date] {
        guard let start = startDate else { return []}
        guard let end = endDate else { return []}
        
        var all: [Date] = [start]
        var currentDate = start
        
        repeat {
            currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
            all.append(currentDate)
        } while compare(firstObj: currentDate, with: end) != 0
        
        all.append(end)
        return all
    }
    
    private func compare(firstObj: Date, with secondObj: Date) -> Int {
        let fyear = calendar.component(.year, from: firstObj)
        let syear = calendar.component(.year, from: secondObj)
        let fmonth = calendar.component(.month, from: firstObj)
        let smonth = calendar.component(.month, from: secondObj)
        
        let yearDiff = fyear - syear
        if(yearDiff == 0) {
            return fmonth - smonth
        }
        return yearDiff
    }
    
    internal func weekdaySymbols() -> [String] {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = locale
        var weekdays: [String] = []        
        for index in 1..<cal.shortWeekdaySymbols.count {
            weekdays.append(cal.shortWeekdaySymbols[index])
        }
        weekdays.append(cal.shortWeekdaySymbols[0])
        return weekdays
    }
    
    internal func monthSymbol(for date: Date?) -> String {
        guard let date = date else { return "" }
        var cal = Calendar(identifier: .gregorian)
        cal.locale = locale
        return cal.monthSymbols[cal.component(.month, from: date)-1]
    }
    
    internal func year(for date: Date?) -> Int {
        guard let date = date else { return 0 }
        return calendar.component(.year, from: date)
    }
    
    internal func isOutOfDate(_ date: Date?) -> Bool {
        guard let date = date else { fatalError() }
        let today = initToStartDay(Date())
        let result = calendar.compare(today, to: date, toGranularity: .second)
        return (result == .orderedDescending)
    }
    
    internal func initToStartDay(_ date: Date?) -> Date {
        guard let date = date else { fatalError() }
        let todayString = dateFormatter.string(from: date)
        let startDay = dateFormatter.date(from: todayString)!
        return startDay
    }
    
    internal func isSame(firstDate obj1: Date?, secondDate obj2: Date?) -> Bool {
        let first = initToStartDay(obj1)
        let second = initToStartDay(obj2)
        let result = calendar.compare(first, to: second, toGranularity: .second)
        return (result == .orderedSame)
    }
}
