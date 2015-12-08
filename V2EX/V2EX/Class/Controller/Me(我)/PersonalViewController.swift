//
//  PersonalViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit

class PersonalViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.tableFooterView = UIView()
    }
    
    
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension PersonalViewController {
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let loginController = UIStoryboard.viewControllerOfStoryboardName("Auth", identifier: "SID_ LoginViewController")
            
            presentViewController(loginController!, animated: true, completion: nil)
        }
    }
}

