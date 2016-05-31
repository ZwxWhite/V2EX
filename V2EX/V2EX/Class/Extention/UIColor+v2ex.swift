//
//  UIColorTool.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/3/2.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(randomInRange(0...255))/255.0, green: CGFloat(randomInRange(0...255))/255.0, blue: CGFloat(randomInRange(0...255))/255.0, alpha: 1)
    }
    
    class func colorWithRGB(value: Int) -> UIColor {
        return UIColor(red: CGFloat((Double((value & 0xFF0000) >> 16))/255.0), green: CGFloat((Double((value & 0xFF00) >> 8))/255.0), blue: CGFloat((Double(value & 0xFF))/255.0), alpha: 1)
    }
}