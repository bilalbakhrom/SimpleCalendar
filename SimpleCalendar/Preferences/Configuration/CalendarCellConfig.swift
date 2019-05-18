//
//  CalendarCellConfig.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

open class CalendarCellConfig {
    
    public enum SelectionStyle {
        case circle
        case square
    }
    
    /// - TAG: DAY COMPONENT
    
    public var dayCellTitleColor: UIColor? = CalendarColor.standard.blue
    
    public var dayCellTitleFont: UIFont? = UIFont.systemFont(ofSize:  CalendarRatio.standard.suitable(of: 14), weight: .regular)
    
    public var dayCellBackgroundColor: UIColor? = CalendarColor.standard.lightGray
    
    public var dayAttributedText: NSAttributedString?
    
    public var selectedDayCellBackgroundColor: UIColor? = CalendarColor.standard.blue
    
    public var selectedCellTitleColor: UIColor? = .white
    
    public var dayCellSelectionStyle: SelectionStyle = .square
    
    public var passedDatesBackgroundColor: UIColor? = CalendarColor.standard.lightGray
    
    public var passedDatesTitleColor: UIColor? = CalendarColor.standard.gray
    
    public var passedDatesFont: UIFont = UIFont.systemFont(ofSize:  CalendarRatio.standard.suitable(of: 14), weight: .regular)
    
    public var passedDatesAttributedText: NSAttributedString?
    
    /**
     If this property is true, user cannot touch previous dates that
     is less than current date.
     
     Default value is false
     */
    public var disableSelectionOfPassedDates = false
    
    
    /// - TAG: WEEKDAY COMPONENT
    
    public var weekdayCellTitleColor: UIColor? = CalendarColor.standard.softGray
    
    public var weekdayCellTitleFont: UIFont? = UIFont.systemFont(ofSize:  CalendarRatio.standard.suitable(of: 12), weight: .bold)
    
    public var weekdayCellBackgroundColor: UIColor? = .clear
    
    public var weekdayAttributedText: NSAttributedString?
}
