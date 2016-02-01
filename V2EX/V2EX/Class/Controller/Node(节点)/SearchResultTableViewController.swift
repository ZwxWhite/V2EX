//
//  SearchResultTableViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/1.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    
    var nodes = [V2NodeModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nodes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell") {
            cell.textLabel?.text = self.nodes[indexPath.row].title
            return cell
        }
        return UITableViewCell()
    }

}
