//
//  TopicViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/17.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.tableFooterView = UIView(frame: CGRectZero)
        }
    }
}


//MARK: - UITableViewDelegate & UITableViewDataSource
extension TopicViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

