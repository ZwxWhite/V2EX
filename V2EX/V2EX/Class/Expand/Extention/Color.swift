//
//  Color.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit


extension UIColor {
    
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(randomInRange(0...255))/255.0, green: CGFloat(randomInRange(0...255))/255.0, blue: CGFloat(randomInRange(0...255))/255.0, alpha: 1)
    }
}