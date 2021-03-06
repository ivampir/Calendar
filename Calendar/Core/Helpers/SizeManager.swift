//
//  SizeManager.swift
//  Calendar
//
//  Created by Vitaliy Ampilogov on 3/23/17.
//  Copyright © 2017 v.ampilogov. All rights reserved.
//

import UIKit

class SizeManager {
    
    static let headerHeight: CGFloat = 64.0
    static let separatorHeight: CGFloat = 1 / UIScreen.main.scale
    static let dayItemWidth = dayItemHeight
    static let screenHeight = UIApplication.shared.delegate?.window??.frame.size.height ?? 0
    static let screenWidth = UIApplication.shared.delegate?.window??.frame.size.width ?? 0
    
    static var dayItemHeight: CGFloat {
        return ceil(screenWidth / CGFloat(Calendar.current.weekdaySymbols.count))
    }
    
    static var calendarDefaultHeight: CGFloat {
        return screenHeight / 2 - headerHeight
    }
    
    static var calendarCollapsedHeight: CGFloat {
        return dayItemHeight * 3
    }
    
    static var calendarLeading: CGFloat {
        return dayItemWidth * CGFloat(Calendar.current.weekdaySymbols.count) - screenWidth
    }
}
