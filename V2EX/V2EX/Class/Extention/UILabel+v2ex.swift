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
        
        var resultSize = CGSizeZero
        if text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
            return resultSize.height
        }
        
        resultSize = NSString(string: text).boundingRectWithSize(CGSize(width: width, height: CGFloat.max), options: [.UsesFontLeading, .UsesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil).size
        
        return resultSize.height + 10
    }
}