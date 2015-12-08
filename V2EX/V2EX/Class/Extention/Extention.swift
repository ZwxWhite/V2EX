//
//  Extention.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/8.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit



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