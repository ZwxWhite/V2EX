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
    
    override func awakeFromNib() {
        
        // 解决卡顿  将试图渲染内容缓存
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
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








