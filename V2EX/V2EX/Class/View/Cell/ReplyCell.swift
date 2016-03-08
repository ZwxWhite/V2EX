//
//  ReplyCell.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/24.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

class ReplyCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet{
            avatarImageView.layer.cornerRadius = 4
            avatarImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var replyContentLabel: UILabel!
    
    weak var delegate: ShowUserInfoProtocol?
    
    override func awakeFromNib() {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
        self.avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "avatarImageViewDidClick"))
    }
    
    var reply: V2Reply? {
        didSet{
            ownerLabel.text = reply?.member?.username
            replyContentLabel.text = reply?.content
            if reply != nil {
                if let avatarUrl = reply!.member?.avatar_normal {
                    avatarImageView.kf_setImageWithURL(NSURL(string: v2exHttps(false) + avatarUrl)!, placeholderImage: nil)
                }
            }
            if let lastModified = reply?.last_modified {
                let lastTouchedTime = NSTimeInterval(lastModified)
                self.timeIntervalLabel.text = relationshipOfDate(NSDate(), anotherDate: NSDate(timeIntervalSince1970: lastTouchedTime))
            }
         }
    }
    
    class func cellHeightWithContent(content: String?) -> CGFloat {
        if let cellContent = content {
            let height = UILabel.heightForView(cellContent, font: UIFont(name: "PingFangSC-Regular", size: 14)!, width: Screen_Width-70)
            return 5 + 40 - 15 + height
        }
        return 0
    }
    
    func avatarImageViewDidClick() {
        if let delegate = self.delegate {
            delegate.showUserInfo(self.reply?.member?.username)
        }
    }
    
}
