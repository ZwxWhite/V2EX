//
//  CategorieItemViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/18.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import Alamofire


class CategoryItemViewController: UIViewController, Contextualizable {
    
    
    @IBOutlet weak var tableView: UITableView!
    

    
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
        
//                case .Tech: apiManager.tab = "tech"
//                case .Creative: apiManager.tab = "creative"
//                case .Play: apiManager.tab = "play"
//                case .Jobs: apiManager.tab = "jobs"
//                case .Deals: apiManager.tab = "deals"
//                case .City: apiManager.tab = "city"
//                case .Qna: apiManager.tab = "qna"
//                case .Hot: apiManager.tab = "hot"
//                case .All: apiManager.tab = "all"
//                case .R2: apiManager.tab = "r2"
//                case .Nodes: apiManager.tab = "nodes"
//                case .Members: apiManager.tab = "members"
//                default: apiManager.tab = "all"
        
    }

    
}





