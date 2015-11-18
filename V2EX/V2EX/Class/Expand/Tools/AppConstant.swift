//
//  AppConstant.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import ReachabilitySwift


public let Screen_Width  = UIScreen.mainScreen().bounds.size.width
public let Screen_Height = UIScreen.mainScreen().bounds.size.height

public let NavigationBar_Height: CGFloat = 64.0
public let Tabbar_Height: CGFloat = 49.0



/**
    获取MainStoryboard 上的controller

    - parameter identifier: controller id

    - returns: controller
 */
public func viewControllerOfMainStoryboard(identifier: String) -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    return storyboard.instantiateViewControllerWithIdentifier(identifier)
}




// MARK: Net

public let V2TimeoutInterval = 30.0
public let V2EXBaseUrl = "https://www.v2ex.com"

public func networkReachability() -> Bool {
    do {
        let reachability = try Reachability.reachabilityForInternetConnection()
        return reachability.currentReachabilityStatus != .NotReachable
    } catch {
        return false
    }
}












