//
//  DateTool.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/17.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import SwiftDate

public func relationshipOfDate(firstDate: NSDate, anotherDate: NSDate) -> String {
    
    let second = firstDate.timeIntervalSinceDate(anotherDate)
    let minite = second / 60
    let hour = minite / 60
    let day = hour / 24

    if minite < 60.0 {
        if (minite < 1.0) {
            return "刚刚"
        }
        return String(Int(minite)) + "分钟前"
    }
    
    if hour < 24.0 {
        return String(Int(hour)) + "小时前"
    }
    
    if day < 7.0 {
        return String(Int(day)) + "天前"
    }
    
    return dateStringWith(anotherDate)
}


public func dateStringWith(date: NSDate) -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = "yyyy年MM月dd日"
    
    return dateFormatter.stringFromDate(date)
}











