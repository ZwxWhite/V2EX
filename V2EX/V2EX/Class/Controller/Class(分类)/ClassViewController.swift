//
//  ClassViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//  分类

import UIKit
import PagingMenuController
import SnapKit

//MARK: life cycle
class ClassViewController: BaseViewController  {
    
    var pagingMenuController: PagingMenuController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configPagingMenuController()
    }
    
    override func viewDidLayoutSubviews() {
        pagingMenuController.view.frame = CGRectMake(0, NavigationBar_Height, Screen_Width, Screen_Height - NavigationBar_Height - Tabbar_Height)
    }
}

//MARK: PagingMenuController
extension ClassViewController {
    
    /**
     设置page页面
     */
    func configPagingMenuController() {
        
        let options = pagingMenuOptions()
        let controllers = pagingControllerItems();
        
        pagingMenuController = PagingMenuController(viewControllers: controllers, options: options)
        view.addSubview(pagingMenuController.view)
    }
    
    
    /**
     分类controller数组
     */
    func pagingControllerItems() -> [ClassItemViewController] {
        
        let items = ["技术","创意","好玩","Apple","酷工作","交易","城市","问与答","最热","全部","R2","节点","关注"];
        var controllers = [ClassItemViewController]()
        for item in items {
            
            let controller = ClassItemViewController()
            controller.title = item
            
            controllers.append(controller)
        }
        return controllers
    }
    
    /**
     page 设置
     */
    func pagingMenuOptions() -> PagingMenuOptions {
        let options = PagingMenuOptions()
        
        options.menuItemMargin = 0
        options.menuHeight = 30
        options.textColor = UIColor.blackColor()
        options.font = UIFont.boldSystemFontOfSize(14)
        options.selectedTextColor = UIColor.whiteColor()
        options.animationDuration = 0.2
        options.menuDisplayMode = .Standard(widthMode: .Fixed(width: 70), centerItem: false, scrollingMode: PagingMenuOptions.MenuScrollingMode.ScrollEnabled)
        options.menuItemMode = .RoundRect(radius: 4, horizontalPadding: 5, verticalPadding: 5, selectedColor: UIColor.blackColor())
        return options
    }
}




