//
//  UILabel.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/3/2.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

extension UILabel {
    
    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        let textSize = NSString(string: text).boundingRectWithSize(CGSizeMake(width, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil)
        return textSize.height + 10
    }
}