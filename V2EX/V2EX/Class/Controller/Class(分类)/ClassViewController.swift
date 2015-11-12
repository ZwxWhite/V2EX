//
//  ClassViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//  分类

import UIKit
import PagingMenuController

//MARK: life cycle
class ClassViewController: BaseViewController  {
    
    var pagingMenuController: PagingMenuController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configPagingMenuController()
    }
}

//MARK: PagingMenuController
extension ClassViewController {
    
    /**
     设置page页面
     */
    func configPagingMenuController() {
        
        let options = PagingMenuOptions()
        options.menuItemMargin = 5
        options.menuDisplayMode = .Standard(widthMode: .Flexible, centerItem: false, scrollingMode: PagingMenuOptions.MenuScrollingMode.ScrollEnabled)

        options.menuHeight = 60
        
        var controllers = [ClassItemViewController]()
        
        for _ in 0...9 {
            let item = ClassItemViewController()
            item.view.backgroundColor = UIColor.randomColor()
            controllers.append(item)
        }
        
        pagingMenuController = PagingMenuController(viewControllers: controllers, options: options)
        pagingMenuController.view.frame = CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height-64)
        
        view.addSubview(pagingMenuController.view)
    }
}




