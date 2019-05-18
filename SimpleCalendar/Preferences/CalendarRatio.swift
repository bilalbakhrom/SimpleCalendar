//
//  CalendarRatio.swift
//  Wallpaper
//
//  Created by Bilal Bakhrom on 16/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal class CalendarRatio {
    
    internal static let standard = CalendarRatio()
    
    private init() {}
    
    private let actualSize = CGSize(width: 375, height: 812)
    private let bounds = UIScreen.main.bounds
    
    internal enum RatioSide {
        case width
        case height
    }
    
    internal func suitable(of size: CGFloat) -> CGFloat {
        let fontRatio = actualSize.width/size
        return bounds.width/fontRatio
    }
    
    internal func scaled(size: CGFloat, accordingTo side: RatioSide) -> CGFloat {
        switch side {
        case .height:
            let ratio = actualSize.height/size
            return bounds.height/ratio
            
        case .width:
            let ratio = actualSize.width/size
            return bounds.width/ratio
        }
    }
    
    internal func scaledSquare(size: CGFloat, accordingTo side: RatioSide) -> CGSize {
        var length: CGFloat
        
        switch side {
        case .height:
            let ratio = actualSize.height/size
            length = bounds.height/ratio
        case .width:
            let ratio = actualSize.width/size
            length = bounds.width/ratio
        }
        
        return CGSize(width: length, height: length)
    }
    
    internal func scaled(width: CGFloat, height: CGFloat) -> CGSize {
        let wRatio = actualSize.width/width
        let hRatio = actualSize.height/height
        let width = bounds.width/wRatio
        let height = bounds.height/hRatio
        return CGSize(width: width, height: height)
    }
}
