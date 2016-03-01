//
//  V2NavigationController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/18.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

class V2NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    
    override func viewDidLoad() {
        
        let target = self.interactivePopGestureRecognizer?.delegate
        
        let pan = UIPanGestureRecognizer(target: target, action: "handleNavigationTransition:")
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        
        self.interactivePopGestureRecognizer?.enabled = false
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count == 1 {
            return false
        }
        return true
    }
}
