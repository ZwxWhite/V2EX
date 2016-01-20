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
    
    var categoryTab: String!
    
    private lazy var topics = [V2TopicModel]()
    
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
        
        self.categoryTab = "apple"
        
    }
}





