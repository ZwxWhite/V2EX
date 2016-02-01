//
//  PersonalViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import Foundation

class PersonalViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension PersonalViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 3
        case 2: return 2
        case 3: return 1
        case 4:
            if let user = v2Realm.objects(V2UserModel).first {
                return user.logined ? 1 : 0
            }
            return 0
        default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UserHeaderCell", forIndexPath: indexPath) as! UserHeaderCell
            cell.reloadData()
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("PersonalLogoutCell", forIndexPath: indexPath) as! PersonalLogoutCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonalDetailCell", forIndexPath: indexPath) as! PersonalDetailCell
        cell.indexPath = indexPath;
        
        return cell        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 {
            if let user = v2Realm.objects(V2UserModel).first {
                if user.logined {
                    return;
                }
            }
            let loginController = UIStoryboard.viewControllerOfStoryboardName("Auth", identifier: "SID_ LoginViewController")
            presentViewController(loginController!, animated: true, completion: nil)
        }
        
        else if indexPath.section == 4 {
            try! v2Realm.write({ () -> Void in
                if let user = v2Realm.objects(V2UserModel).first {
                    v2Realm.delete(user)
                }
                self.tableView.reloadData()
            });
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        return 50
    }
}

