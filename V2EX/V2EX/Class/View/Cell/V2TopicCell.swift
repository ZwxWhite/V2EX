//
//  V2TopicCell.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/17.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import Kingfisher

class V2TopicCell: UITableViewCell {

    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nodeLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var lastTouchedLabel: UILabel!
    
    var topic: V2Topic? {
        didSet{
            
            self.titleLabel.text = self.topic?.title
            self.nodeLabel.text = self.topic?.node?.title
            self.userName.text = self.topic?.member?.username
            self.lastTouchedLabel.text = String(self.topic?.last_modified)
            self.avatarImage.layer.cornerRadius = 4.0
            self.avatarImage.layer.masksToBounds = true
            
            if let avatarImageUrl = self.topic?.member?.avatar_normal {
                self.avatarImage.kf_setImageWithURL(NSURL(string: "https:" + avatarImageUrl)!, placeholderImage: nil)
            }
        }
    }
}
