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

// MARK: - Net

public let V2TimeoutInterval = 30.0

public let v2exBaseUrl: String = "https://www.v2ex.com"

public func v2exHttps(https:Bool) -> String {
    if https {
        return "https:"
    }
    return "http:"
}

public func networkReachability() -> Bool {
    do {
        let reachability = try Reachability.reachabilityForInternetConnection()
        return reachability.currentReachabilityStatus != .NotReachable
    } catch {
        return false
    }
}












