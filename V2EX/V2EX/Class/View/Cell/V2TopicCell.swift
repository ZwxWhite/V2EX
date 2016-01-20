//
//  V2TopicCell.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/17.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import Kingfisher


class V2TopicCell: UITableViewCell,Contextualizable {

    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var lastModifiedLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet{
            avatarImage.layer.cornerRadius = 4
            avatarImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var repliesLabel: UILabel! {
        didSet{
            repliesLabel.layer.cornerRadius = 4
            repliesLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nodeLabel: UILabel! {
        didSet{
            nodeLabel.layer.cornerRadius = 4
            nodeLabel.layer.masksToBounds = true
        }
    }
    
    var topicViewModel: V2TopicModel? {
        didSet{
            if let topic = topicViewModel {
                
                titleLabel.text = topic.title
                userName.text = topic.userName
                lastModifiedLabel.text = topic.lastModified
                avatarImage.kf_setImageWithURL(NSURL(string: topic.avatarImageString!)!, placeholderImage: nil)
                repliesLabel.text = topic.replies
                nodeLabel.text = topic.node
            } else {
                V2Error(currentDebugContext(),"model为nil").logError()
            }
        }
    }
}



struct V2TopicModel {
    var avatarImageString: String?
    var title: String!
    var userName: String!
    var lastModified: String!
    var replies: String!
    var node: String!
    
    init(topic:V2Topic){
        if let modelAvatarImageString = topic.member?.avatar_normal {
            self.avatarImageString = "https:" + modelAvatarImageString
        } else {
            self.avatarImageString = nil
        }
        
        if let modelTitle = topic.title {
            self.title = modelTitle
        } else {
            self.title = ""
        }
        
        if let modelUserName = topic.member?.username {
            self.userName = modelUserName
        } else {
            self.userName = ""
        }
        
        if let modelLastTouched = topic.last_modified {
            
            let lastTouchedTime = NSTimeInterval(modelLastTouched)
            self.lastModified = relationshipOfDate(NSDate(), anotherDate: NSDate(timeIntervalSince1970: lastTouchedTime))
        } else {
            self.lastModified = ""
        }
        
        if let modelReplies = topic.replies {
            self.replies = String(modelReplies)
        } else {
            self.replies = "0"
        }
        
        if let modelNode = topic.node?.title {
            self.node = modelNode+"   "
        } else {
            self.node = ""
        }
    }
}






