//
//  AppDelegate.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/11.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        configTools()
        configV2exStyle(application)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {}

    func applicationDidEnterBackground(application: UIApplication) {}

    func applicationWillEnterForeground(application: UIApplication) {}

    func applicationDidBecomeActive(application: UIApplication) {}

    func applicationWillTerminate(application: UIApplication) {}
}



extension AppDelegate {
    
    func configTools() {
        Fabric.sharedSDK().debug = true
        Fabric.with([Crashlytics.self()])
    }
    
    func configV2exStyle(application: UIApplication) {

        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
    }
}








