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
class DailyHotViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,Contextualizable {

    @IBOutlet weak var tableView: UITableView! {
        didSet{
            self.tableView.tableFooterView = UIView()
        }
    }
    
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
            

    }
    
    
    private func addRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(self.refreshControl!)
    }
}







