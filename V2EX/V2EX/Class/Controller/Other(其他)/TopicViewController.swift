//
//  TopicViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/17.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TopicViewController: UIViewController {
    
    var topicInfo: V2TopicModel?
    private var topic: V2Topic?
    private var replies = [V2Reply]()
    private var topicContentCellHeight: CGFloat = 0

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.tableFooterView = UIView(frame: CGRectZero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "话题详情"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        self.loadData()
    }
    
    
    // 3dtouch
    override func previewActionItems() -> [UIPreviewActionItem] {
        let actionReply = UIPreviewAction(title: "回复", style: .Default) { (_, _) -> Void in
            printLog("点击了回复")
        }
        return [actionReply]
    }
    
    func loadData() {
        
        // topic
        TopicRequest(id: topicInfo?.id).start()?.responseJSON(completionHandler: { (response) -> Void in
            switch response.result {
            case .Success(let responseJson):
                self.topic = V2Topic(json: JSON(responseJson.firstObject as! NSDictionary))
                self.topicInfo = V2TopicModel(topic: self.topic!)
                self.tableView.reloadData()
                
                RepliesRequest(topicID: self.topicInfo?.id).start()?.responseJSON(completionHandler: { (response) -> Void in
                    switch response.result {
                    case .Success(let responseJson):
                        if let responseArray = responseJson as? NSArray {
                            for dictionary in responseArray {
                                let reply = V2Reply(json: JSON(dictionary))
                                self.replies.append(reply)
                            }
                            self.tableView.reloadData()
                        }
                    case .Failure(let error):
                        print(error)
                    }
                })
                
            case .Failure(let error):
                print(error)
            }
        })
        
        
    }
}


//MARK: - UITableViewDelegate & UITableViewDataSource
extension TopicViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (self.topic != nil) ? 2 : 1
        }
        return replies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("TopicUserInfoCell") as! TopicUserInfoCell
                cell.topic = topicInfo
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("TopicContentCell") as! TopicContentCell
                cell.content = topic?.content_rendered
                cell.contentHeightChanged = { [weak self] (height:CGFloat) -> Void  in
                    self?.topicContentCellHeight = height
                    self?.tableView.reloadData()
                }
                return cell
            }
        }
        
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TopicReplyCell") as! ReplyCell
            cell.reply = replies[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return TopicUserInfoCell.cellHeightWithContent(topicInfo?.title)
            } else if indexPath.row == 1 {
                return self.topicContentCellHeight
            }
        } else if indexPath.section == 1 {
            return ReplyCell.cellHeightWithContent(replies[indexPath.row].content)
        }
        
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

