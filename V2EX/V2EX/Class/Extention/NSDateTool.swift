//
//  NSDateTool.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/3/2.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

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
