//
//  ReplyViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/5/6.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    
    
    var replyMember: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确认", style: .Done, target: self, action: #selector(ReplyViewController.commit))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "关闭", style: .Done, target: self, action: #selector(ReplyViewController.dismiss))
    }
}

extension ReplyViewController {
    func commit() {
        
    }
    
    func dismiss() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
