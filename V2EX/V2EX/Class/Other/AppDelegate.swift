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
import RealmSwift

let v2Realm = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        configTools()
        configStyle(application)
        
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
    
    func configStyle(application: UIApplication) {

        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().tintColor = UIColor.colorWithRGB(0x565656)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), forBarMetrics: .Default)
        
        #if DEBUG
        let fpsLabel = V2FPSLabel(frame: CGRectMake(Screen_Width-70, 20, 55, 20))
        self.window?.rootViewController?.view.addSubview(fpsLabel)
        #else
        #endif
    }
}








