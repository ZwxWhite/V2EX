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
class CategoriesViewController: UIViewController, UIViewController3DTouch  {
    
    private var pagingMenuController: PagingMenuController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        check3DTouch()
        configPagingMenuController()
    }
    
    override func viewDidLayoutSubviews() {
        pagingMenuController.view.frame = CGRectMake(0, NavigationBar_Height, Screen_Width, Screen_Height - NavigationBar_Height - Tabbar_Height)
    }
}

//MARK: PagingMenuController
extension CategoriesViewController {
    
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
    func pagingControllerItems() -> [CategoryItemViewController] {
        
        let titles = ["技术","创意","好玩","Apple","酷工作","交易","城市","问与答","最热","全部","R2"];
        let tabs = ["tech","creative","play","apple","jobs","deals","city","qna","hot","all","r2"]
        var controllers = [CategoryItemViewController]()
        for index in 0...titles.count-1 {
            
            if let controller = UIStoryboard.viewControllerOfStoryboardName("Main", identifier: "SID_CategoryItemViewController") as? CategoryItemViewController {
                controller.title = titles[index]
                controller.categoryTab = tabs[index]
                controller.categoriesViewController = self
                controllers.append(controller)
            }
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
        options.textColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 67/255.0, alpha: 1)
        options.font = UIFont.boldSystemFontOfSize(13)
        options.selectedFont = UIFont.boldSystemFontOfSize(13)
        options.selectedTextColor = UIColor.whiteColor()
        options.animationDuration = 0.2
        options.menuDisplayMode = .Standard(widthMode: .Fixed(width: 70), centerItem: false, scrollingMode: PagingMenuOptions.MenuScrollingMode.ScrollEnabled)
        options.menuItemMode = .RoundRect(radius: 4, horizontalPadding: 5, verticalPadding: 5, selectedColor: UIColor(red: 51/255.0, green: 51/255.0, blue: 67/255.0, alpha: 1))
        return options
    }
}

// MARK: - 3DTouch
extension CategoriesViewController: UIViewControllerPreviewingDelegate{
    
    func previewingContext(previewingContext: UIViewControllerPreviewing,var viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let currentViewController = self.pagingMenuController.currentViewController as? CategoryItemViewController else {
            return nil
        }
        
        location = self.view.convertPoint(location, toView: (self.pagingMenuController.currentViewController as! CategoryItemViewController).tableView)
        
        guard let indexPath = currentViewController.tableView.indexPathForRowAtPoint(location), _ = currentViewController.tableView.cellForRowAtIndexPath(indexPath) else {
            return nil
        }
        
        guard let topicViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SID_TopicViewController") as? TopicViewController else {
            return nil
        }
        
        topicViewController.topicInfo = currentViewController.topics[indexPath.row]
        let cellFrame = currentViewController.tableView.cellForRowAtIndexPath(indexPath)!.frame
        previewingContext.sourceRect = view.convertRect(cellFrame, fromCoordinateSpace: currentViewController.tableView)
        
        return topicViewController
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
        self.showViewController(viewControllerToCommit, sender:nil)
    }
}




