//
//  UserHeaderCell.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/4.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit

class UserHeaderCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet{
            avatarImageView.layer.cornerRadius = 3
            avatarImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func reloadData() {
        if let user = v2Realm.objects(V2UserModel).first {
            usernameLabel.text = user.username
            if let tagline = user.tagline where tagline.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
                descriptionLabel.text = "简介: " + tagline
            } else {
                descriptionLabel.text = "这家伙很懒,什么都没留下"
            }
            if let avatarUrl = user.avatar_normal {
                avatarImageView.kf_setImageWithURL(NSURL(string: v2exHttps(false) + avatarUrl)!, placeholderImage: UIImage(named: "avatar_default"))
            }
        } else {
            usernameLabel.text = "未登录"
            descriptionLabel.text = "简介: 暂无简介"
            avatarImageView.image = nil
        }
    }
}
