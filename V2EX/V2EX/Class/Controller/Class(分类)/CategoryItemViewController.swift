//
//  CategorieItemViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/18.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import Alamofire

public enum CategoryItem {
    case Tech
    case Creative
    case Play
    case Apple
    case Jobs
    case Deals
    case City
    case Qna
    case Hot
    case All
    case R2
    case Nodes
    case Members
}

class CategoryItemViewController: BaseViewController, Contextualizable, ApiRequestCallBack {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var categotyItem: CategoryItem?

    private lazy var apiManager = CategoryApiManager()
    
    private lazy var topics = [V2TopicViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}



// MARK: UITableViewDelegate & UITableViewDataSource
extension CategoryItemViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let topicCell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as? V2TopicCell {
            let topicViewModel = topics[indexPath.row]
            topicCell.topicViewModel = topicViewModel
            return topicCell
        }
        V2Error(currentDebugContext(),"cell error").logError()
        return UITableViewCell()
    }
}


// MARK: LoadData
extension CategoryItemViewController {
    private func loadData() {
        
        if let categotyTab = categotyItem {
            switch categotyTab {
                case .Tech: apiManager.tab = "tech"
                case .Creative: apiManager.tab = "creative"
                case .Play: apiManager.tab = "play"
                case .Jobs: apiManager.tab = "jobs"
                case .Deals: apiManager.tab = "deals"
                case .City: apiManager.tab = "city"
                case .Qna: apiManager.tab = "qna"
                case .Hot: apiManager.tab = "hot"
                case .All: apiManager.tab = "all"
                case .R2: apiManager.tab = "r2"
                case .Nodes: apiManager.tab = "nodes"
                case .Members: apiManager.tab = "members"
                default: apiManager.tab = "all"
            }
        } else {
            V2Error(currentDebugContext(),"未知类型").logError()
            return;
        }
        
        
        do {
            apiManager.delegate = self
            try apiManager.start()
        } catch HttpRequestErrorType.NoNetWork{
            V2Error(currentDebugContext(),"网络不通").logError()
        } catch HttpRequestErrorType.ParamsError{
            V2Error(currentDebugContext(),"参数错误").logError()
        } catch {
            V2Error(currentDebugContext(),"未知错误").logError()
        }
    }
    
    internal func requestFinish(response: Response<AnyObject, NSError>) {
        if let result = response.result.value as? NSArray {
            for dictionary in result {
                
                let topic = V2Topic(dictionary: dictionary as! NSDictionary)
                topics.append(V2TopicViewModel(topic: topic))
            }
            tableView.reloadData()
        } else {
            V2Error(currentDebugContext(),"格式不正确").logError()
        }
    }
    
    internal func requestFailed(error: NSError) {
        V2Error(currentDebugContext(),error.domain).logError()
    }
}





