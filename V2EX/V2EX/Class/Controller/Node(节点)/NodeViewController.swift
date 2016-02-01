//
//  NodeViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//  节点

import UIKit
import Alamofire

class NodeViewController: UITableViewController, Contextualizable, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {

    
    var nodes = [V2NodeModel]()
    
    var searchController: UISearchController!
    var resultTableViewController = SearchResultTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultTableViewController = SearchResultTableViewController()
        self.resultTableViewController.tableView.delegate = self
        
        self.searchController = UISearchController(searchResultsController: self.resultTableViewController)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadNodes()
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
                let cache = NSURLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
                NSURLCache.setSharedURLCache(cache)
                self.tableView.reloadData()
            case .Failure(let error):
                V2Error(self.currentDebugContext(),error.description).logError()
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}



//MARK: - UISearchResultsUpdating
extension NodeViewController {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchResult = self.nodes
        let strippedString = searchController.searchBar.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let filterResult = searchResult.filter { (node) -> Bool in
            return node.name.containsString(strippedString) || node.title.containsString(strippedString)
        }
        let resultController = searchController.searchResultsController as! SearchResultTableViewController
        resultController.nodes = filterResult
        resultController.tableView.reloadData()
    }
}

//MARK: - UISearchBarDelegate
extension NodeViewController {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if self.nodes.count <= 0 {
            self.loadNodes()
        }
    }
}

