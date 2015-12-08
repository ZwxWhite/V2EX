//
//  PersonalViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            self.tableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension PersonalViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let headerCell = tableView.dequeueReusableCellWithIdentifier("UserHeaderCell", forIndexPath: indexPath) as! UserHeaderCell
            
            return headerCell
        }
        
        else if indexPath.section == 1 {
            let logoutCell = tableView.dequeueReusableCellWithIdentifier("LogoutCell", forIndexPath: indexPath)
            
            return logoutCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 170
        }
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

