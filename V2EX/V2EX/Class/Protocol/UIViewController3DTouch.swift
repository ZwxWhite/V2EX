//
//  UIViewController3DTouch.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/3/2.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

protocol UIViewController3DTouch: UIViewControllerPreviewingDelegate {
    
    func check3DTouch()
}

extension UIViewController3DTouch where Self: UIViewController {
    
    func check3DTouch() {
        if self.traitCollection.forceTouchCapability == .Available {
            self.registerForPreviewingWithDelegate(self, sourceView: self.view)
        } else {
            printLog("3Dtouch Unavailable")
        }
    }
}
