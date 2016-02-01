//
//  NodeViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//  节点

import UIKit
import Alamofire

class NodeViewController: UITableViewController, Contextualizable {

    
    var nodes = [V2NodeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadNodes()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}


extension NodeViewController {
    
    private func loadNodes() {
        request(.GET, v2exBaseUrl+"/api/nodes/all.json", parameters: nil, encoding: .URL, headers: nil).responseJSON { (response) -> Void in
            switch response.result {
            case .Success(let responseResult):
                if let responseArray = responseResult as? NSArray {
                    for dictionary in responseArray {
                        let node = V2NodeModel()
                        node.setupWithDictionary(dictionary as! [String : AnyObject])
                        self.nodes.append(node)
                    }
                }
                self.tableView.reloadData()
            case .Failure(let error):
                V2Error(self.currentDebugContext(),error.description).logError()
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nodes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("NodeCell") {
            if let label = cell.contentView.viewWithTag(1001) as? UILabel{
                label.text = self.nodes[indexPath.row].name
            }
            return cell
        }
        return UITableViewCell()
    }
}
