//
//  CategorieItemViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/18.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import Alamofire
import Ji


class CategoryItemViewController: UIViewController, Contextualizable, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoryTab: String!
    private lazy var topics = [V2TopicModel]()
    private var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        addRefresh()
    }
}



// MARK: - UITableViewDelegate & UITableViewDataSource
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    private func addRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(self.refreshControl!)
    }
}


// MARK: - LoadData
extension CategoryItemViewController {
    func loadData() {
        request(.GET, v2exBaseUrl, parameters: ["tab":self.categoryTab], encoding: .URL, headers: nil).responseString { (response) -> Void in
            switch response.result{
            case .Success(let responseString):
                self.topics.removeAll()
                self.topics.appendContentsOf(V2TopicModel.responseConfigWith(responseString))
                self.tableView.reloadData()
            case .Failure(let error):
                V2Error(self.currentDebugContext(),error.description).logError()
            }
            self.refreshControl?.endRefreshing()
        }
    }
}





