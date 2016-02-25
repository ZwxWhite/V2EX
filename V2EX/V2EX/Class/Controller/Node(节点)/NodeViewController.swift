//
//  NodeViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//  节点

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

class NodeViewController: UITableViewController, Contextualizable, UISearchControllerDelegate {

    
    var nodes = [V2NodeModel]()
    
    var searchRecords: Results<V2NodeRecord>!
    
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
        self.loadSearchRecords();
    }
}



// MARK: - UITableViewDelegate & UITableViewDataSource
extension NodeViewController {
    
    private func loadSearchRecords() {
        self.searchRecords = v2Realm.objects(V2NodeRecord)
        
        self.tableView.reloadData()
    }

    private func loadNodes() {
        request(.GET, v2exBaseUrl+"/api/nodes/all.json", parameters: nil, encoding: .URL, headers: nil).responseJSON { (response) -> Void in
            switch response.result {
            case .Success(let responseResult):
                if let responseArray = responseResult as? NSArray {
                    for dictionary in responseArray {
                        let node = V2NodeModel(json: JSON(dictionary))
                        self.nodes.append(node)
                    }
                }
                let cache = NSURLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
                NSURLCache.setSharedURLCache(cache)
            case .Failure(let error):
                V2Error(self.currentDebugContext(),error.description).logError()
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchRecords = self.searchRecords {
            return searchRecords.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("NodeCell") {
            if let label = cell.contentView.viewWithTag(1001) as? UILabel{
                let record = self.searchRecords[indexPath.row] as V2NodeRecord
                label.text = record.searchText
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
extension NodeViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchResult = self.nodes
        let strippedString = searchController.searchBar.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let filterResult = searchResult.filter { (node) -> Bool in
            return node.name!.containsString(strippedString) || node.title!.containsString(strippedString)
        }
        let resultController = searchController.searchResultsController as! SearchResultTableViewController
        resultController.nodes = filterResult
        resultController.tableView.reloadData()
    }
}

//MARK: - UISearchBarDelegate
extension NodeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        let record = V2NodeRecord()
        record.searchText = searchBar.text
        
        try! v2Realm.write({ () -> Void in
            v2Realm.add(record)
        })
        self.loadSearchRecords()
    }
}

