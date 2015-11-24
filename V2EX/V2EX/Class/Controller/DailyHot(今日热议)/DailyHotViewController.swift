//
//  DailyHotViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//  今日热议

import UIKit
import Alamofire
import DGElasticPullToRefresh

// MARK: - Life cycle
class DailyHotViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,Contextualizable,ApiRequestCallBack {

    @IBOutlet weak var tableView: UITableView! {
        didSet{
            self.tableView.tableFooterView = UIView()
        }
    }
    
    /// 请求
    private lazy var apiManager = DailyHotApiManager()
    
    /// 数据源
    private var topics = [V2TopicViewModel]()
    
    /// 刷新
    private var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        addRefresh()
    }
    
    deinit {
        tableView.dg_removePullToRefresh()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DailyHotViewController {
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.reloadData()
    }
}


// MARK: - LoadData
extension DailyHotViewController {
    func loadData() {
            
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
        refreshControl?.endRefreshing()
    }
    
    internal func requestFailed(error: NSError) {
        refreshControl?.endRefreshing()
        V2Error(currentDebugContext(),error.domain).logError()
    }
    
    private func addRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        tableView.addSubview(refreshControl)
    }
}







