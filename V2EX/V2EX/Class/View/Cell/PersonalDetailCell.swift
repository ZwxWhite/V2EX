//
//  PersonalDetailCell.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/14.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit

class PersonalDetailCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    let detailTexts = [[],["节点收藏","主题收藏","特别关注"],["主题","回复"],["设置"],[]]
    
    var indexPath: NSIndexPath? {
        didSet{
            self.contentLabel.text = detailTexts[(indexPath?.section)!][(indexPath?.row)!]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
