//
//  V2TopicCell.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/17.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit

class V2TopicCell: UITableViewCell {

    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nodeLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var lastTouchedLabel: UILabel!
    
    var topic: V2Topic? {
        didSet{
            
        }
    }
}
