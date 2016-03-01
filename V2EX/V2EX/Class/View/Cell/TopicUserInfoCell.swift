//
//  TopicUserInfoCell.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/18.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

class TopicUserInfoCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var nodeLabel: UILabel!
    @IBOutlet weak var topicTitleLabel: UILabel!
    
    var topic: V2TopicModel?{
        didSet{
            if let topicModel = topic {
                avatarImageView.kf_setImageWithURL(NSURL(string: topicModel.avatarImageString!)!, placeholderImage: nil)
                userLabel.text = topicModel.userName
                nodeLabel.text = topicModel.node
                topicTitleLabel.text = topicModel.title
                
                if let date = topic?.created {
                    createdLabel.text = "创建时间 \(String(format:"%02d",date.month))月\(String(format:"%02d",date.day))日 \(String(format:"%02d",date.hour)):\(String(format:"%02d",date.minute))"
                } else {
                    createdLabel.text = ""
                }
            } else {
                userLabel.text = "owner"
                createdLabel.text = ""
            }
        }
    }
    
    class func cellHeightWithContent(content: String?) -> CGFloat {
        if let cellContent = content {
            let height = UILabel.heightForView(cellContent, font: UIFont(name: "PingFangSC-Semibold", size: 17)!, width: Screen_Width-20)
            return 5 + 40 + 15 + height
        }
        return 0
    }

}
