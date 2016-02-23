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
                    createdLabel.text = "创建时间 \(date.month)月\(date.day)日 \(date.hour):\(date.minute)"
                } else {
                    createdLabel.text = ""
                }
            } else {
                userLabel.text = "owner"
                createdLabel.text = ""
            }
        }
    }
    
    class func cellHeightWithTopic(model: V2TopicModel?) -> CGFloat {
        if let topic = model {
            let title = "李世石和谷歌 AlphaGo 的围棋五番棋，我认为李世石会赢，并且一旦赢，谷歌电脑会输的一败涂地。"
            let titleRect = title.boundingRectWithSize(CGSize(width: Screen_Width, height: CGFloat(FLT_MAX)), options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: nil, context: nil)
            
            return CGFloat(5+40+15) + titleRect.height

        }
        return 0
    }
    
}
