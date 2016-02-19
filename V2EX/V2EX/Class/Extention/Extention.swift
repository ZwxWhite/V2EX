//
//  Extention.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/8.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit


// MARK: - UIStoryboard
extension UIStoryboard {
    /**
     获取MainStoryboard 上的controller
     
     - parameter identifier: controller id
     
     - returns: controller
     */
    class public func viewControllerOfStoryboardName(storyboardName: String, identifier: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: NSBundle.mainBundle())
        return storyboard.instantiateViewControllerWithIdentifier(identifier)
    }
}


// MARK: - UIColor
extension UIColor {
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(randomInRange(0...255))/255.0, green: CGFloat(randomInRange(0...255))/255.0, blue: CGFloat(randomInRange(0...255))/255.0, alpha: 1)
    }
    
    class func colorWithRGB(value: Int) -> UIColor {
        return UIColor(red: CGFloat((Double((value & 0xFF0000) >> 16))/255.0), green: CGFloat((Double((value & 0xFF00) >> 8))/255.0), blue: CGFloat((Double(value & 0xFF))/255.0), alpha: 1)
    }
}

// MARK: - NSDate
extension NSDate {
    
    func year() -> Int {
        if let components = componentForDate(self, unit: .Year) {
            return components.year
        }
        return 0
    }
    
    func month() -> Int {
        if let components = componentForDate(self, unit: .Month) {
            return components.month
        }
        return 0
    }
    
    func day() -> Int {
        if let components = componentForDate(self, unit: .Day) {
            return components.day
        }
        return 0
    }
    
    func hour() -> Int {
        if let components = componentForDate(self, unit: .Hour) {
            return components.hour
        }
        return 0
    }
    
    func minute() -> Int {
        if let components = componentForDate(self, unit: .Minute) {
            return components.minute
        }
        return 0
    }
    
    func second() -> Int {
        if let components = componentForDate(self, unit: .Second) {
            return components.second
        }
        return 0
    }
    
    
    func componentForDate(date:NSDate, unit: NSCalendarUnit) -> NSDateComponents? {
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let dateComponents = calendar?.components(unit, fromDate: self)
        return dateComponents
    }
}










