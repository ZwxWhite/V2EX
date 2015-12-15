//
//  UserHeaderCell.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/4.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit

class UserHeaderCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func reloadData() {
        if let user = v2Realm.objects(V2UserModel).first {
            avatarImageView.kf_setImageWithURL(NSURL(string: user.avatar_normal)!, placeholderImage: nil)
        }
    }
}
