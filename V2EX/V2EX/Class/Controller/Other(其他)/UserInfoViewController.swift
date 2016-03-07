//
//  UserInfoViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/3/7.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var username: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = username
    }

}


extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberInfoHeaderCell") as! MemberInfoHeaderCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
}