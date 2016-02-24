//
//  TopicViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/17.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit
import Alamofire

class TopicViewController: UIViewController {
    
    var topicInfo: V2TopicModel?
    var topic: V2Topic?
    var currentPage: Int!
    var replies = [V2Reply]()

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.tableFooterView = UIView(frame: CGRectZero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "话题详情"
        currentPage = 1
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        self.loadData()
    }
    
    func loadData() {
        
        // topic
        TopicRequest(id: topicInfo?.id).start()?.responseJSON(completionHandler: { (response) -> Void in
            switch response.result {
            case .Success(let responseJson):
                self.topic = V2Topic(dictionary: responseJson.firstObject as! NSDictionary)
                self.tableView.reloadData()
            case .Failure(let error):
                print(error)
            }
        })
        
        RepliesRequest(topicID: topicInfo?.id, page: currentPage).start()?.responseJSON(completionHandler: { (response) -> Void in
            switch response.result {
            case .Success(let responseJson):
                self.topic = V2Topic(dictionary: responseJson.firstObject as! NSDictionary)
                self.tableView.reloadData()
            case .Failure(let error):
                print(error)
            }
        })
    }
}


//MARK: - UITableViewDelegate & UITableViewDataSource
extension TopicViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.topic != nil) ? 2 : 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TopicUserInfoCell") as! TopicUserInfoCell
            cell.topic = topicInfo
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TopicContentCell")
            (cell?.contentView.viewWithTag(10002) as! UILabel).text = topic?.content
            return cell!
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

