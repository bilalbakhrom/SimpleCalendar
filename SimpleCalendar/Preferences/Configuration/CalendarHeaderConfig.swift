//
//  CalendarHeaderConfig.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 18/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

open class CalendarHeaderConfig {

    public var sectionHeaderFont: UIFont = UIFont.systemFont(ofSize:  CalendarRatio.standard.suitable(of: 12), weight: .bold)
    
    public var sectionHeaderTextColor: UIColor? = CalendarColor.standard.softGray
    
    public var sectionHeaderBackgrounColor: UIColor = CalendarColor.standard.silver
    
}
