//
//  CalendarConfig.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

open class CalendarConfig {
    
    public var backgroundColor: UIColor? = .white
    
    public var barTitle: String? = "Calendar"
    
    public var barTitleColor: UIColor? =  CalendarColor.standard.blue
    
    public var barTitleFont: UIFont = UIFont.systemFont(ofSize: CalendarRatio.standard.suitable(of: 17), weight: .bold)
    
    public var barImage: UIImage?
    
    public var barImageTintColor: UIColor =  CalendarColor.standard.softGray
    
    public var barBackgroundColor: UIColor? = .white
    
    public var locale: Locale? = Locale(identifier: "en-US")
    
    /**
     Total number of day selection.
     
     If selectionLimit is reached, then stops selection of day cells. If you
     set selectionLimit to zero, it will be unlimited.
     
     - Important: Default number is equal to zero.
     */
    public var selectionLimit: Int = 0
    
    /**
     Closes calendar window if selection limit is reached.
     
     Default value is equalt to false
     */
    public var shouldCloseIfLimitReached = false
    
    public var prefersStatusBarHidden: Bool = false
    
    public var preferredStatusBarStyle: UIStatusBarStyle = .default
        
    internal var cellConfig = CalendarCellConfig()
    
    internal var dateConfig = CalendarDateConfig()
    
    internal var headerConfig = CalendarHeaderConfig()
    
    public func configureCell(_ completion: @escaping (CalendarCellConfig) -> Void) {
        completion(cellConfig)
    }
    
    public func configureDate(_ completion: @escaping (CalendarDateConfig) -> Void) {
        completion(dateConfig)
    }
    
    public func configureHeader(_ completion: @escaping (CalendarHeaderConfig) -> Void) {
        completion(headerConfig)
    }
}
