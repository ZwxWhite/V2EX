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
    
    // type
    enum ShortcutIdentifier: String {
        case First
        case Second
        
        init?(fullType: String) {
            guard let last = fullType.componentsSeparatedByString(".").last else { return nil }
            self.init(rawValue: last)
        }
        
        var type: String {
            return NSBundle.mainBundle().bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    // static properties
    static let applicationShortcutUserInfoIconKey = "applicationShrotcutUserInfoIconKey"

    var window: UIWindow?
    
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // 3DTouch config
        var shouldPerformAdditionalDelegateHandling = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            
            launchedShortcutItem = shortcutItem
            shouldPerformAdditionalDelegateHandling = false
        }
        
        if let shortcutItems = application.shortcutItems where shortcutItems.isEmpty {
            
            let shortcut1 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.First.type, localizedTitle: "localizedTitle", localizedSubtitle: "subtitle", icon: UIApplicationShortcutIcon(templateImageName: "login_cancel"), userInfo: [AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.Play.rawValue])
            
            let shortcut2 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.Second.type, localizedTitle: "Pause", localizedSubtitle: "Will Pause an item", icon: UIApplicationShortcutIcon(type: .Share), userInfo: [
                AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.Pause.rawValue
            ])
            
            application.shortcutItems = [shortcut1, shortcut2]
        }
        
        configTools()
        configStyle(application)
        
        return shouldPerformAdditionalDelegateHandling
    }
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        switch (shortCutType) {
        case ShortcutIdentifier.First.type:
            handled = true
        case ShortcutIdentifier.Second.type:
            handled = true
        default: break
        }
        
        return handled
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        guard let shortcut = launchedShortcutItem else { return }
        handleShortCutItem(shortcut)
        launchedShortcutItem = nil
    }

    func applicationWillResignActive(application: UIApplication) {}
    
    func applicationDidEnterBackground(application: UIApplication) {}
    
    func applicationWillEnterForeground(application: UIApplication) {}
    
    func applicationWillTerminate(application: UIApplication) {}
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
    }
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








