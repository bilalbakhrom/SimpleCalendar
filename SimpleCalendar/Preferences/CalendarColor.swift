//
//  CalendarColor.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal class CalendarColor {
    
    internal static let standard = CalendarColor()
    
    private init() {}
    
    /// - TAG: BLUE
    
    /// 51:102:153
    internal var blue: UIColor {
        return UIColor(red: 51/255, green: 102/255, blue: 153/255, alpha: 1.0)
    }
    
    /// - TAG: RED
    
    /// 252:106:104
    internal var softRed: UIColor {
        return UIColor(red: 252/255, green: 106/255, blue: 104/255, alpha: 1.0)
    }
    
    /// 255:51:0
    internal var lightRed: UIColor {
        return UIColor(red: 255/255, green: 51/255, blue: 0, alpha: 1.0)
    }
    
    
    /// - TAG: GRAY
    
    /// 112:112:112
    internal var gray: UIColor {
        return UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
    }
    
    /// 161:169:195
    internal var softGray: UIColor {
        return UIColor(red: 161/255, green: 169/255, blue: 195/255, alpha: 1.0)
    }
    
    /// 249:249:249
    internal var lightGray: UIColor {
        return UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
    }
    
    /// 241:242:246
    internal var silver: UIColor {
        return UIColor(red: 241/255, green: 242/255, blue: 246/255, alpha: 1.0)
    }
    
    /// 51:51:51
    internal var black: UIColor {
        return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    }
    
    /// - TAG: GREEN
    
    /// 92:184:92
    internal var lightGreen: UIColor {
        return UIColor(red: 92/255, green: 184/255, blue: 92/255, alpha: 1.0)
    }
}
