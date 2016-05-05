//
//  DailyHotViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//  今日热议

import UIKit
import Alamofire
import SwiftyJSON

// MARK: - Life cycle
class DailyHotViewController: UIViewController,Contextualizable, UIViewController3DTouch {

    @IBOutlet weak var tableView: UITableView! {
        didSet{
            self.tableView.tableFooterView = UIView()
        }
    }
    
    private var topics = [V2TopicModel]()
    
    private var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        addRefresh()
        check3DTouch()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DailyHotViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let topicCell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as? V2TopicCell {
            return topicCell
        }
        V2Error(currentDebugContext(),"cell error").logError()
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let topicController = self.storyboard?.instantiateViewControllerWithIdentifier("SID_TopicViewController") as! TopicViewController
        topicController.topicInfo = self.topics[indexPath.row]
        navigationController?.pushViewController(topicController, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let tpoicModel = topics[indexPath.row]
        if cell.isKindOfClass(V2TopicCell) {
            (cell as! V2TopicCell).topicModel = tpoicModel
        }
    }
}


// MARK: - LoadData
extension DailyHotViewController {
    func loadData() {
        let request = DailyHotRequest()
        request.start()?.responseJSON(completionHandler: { (response) -> Void in
            if let result = response.result.value as? NSArray {
                self.topics.removeAll()
                for dictionary in result {
                    let topic = V2Topic(json: JSON(dictionary))
                    self.topics.append(V2TopicModel(topic: topic))
                }
                self.tableView.reloadData()
            } else {
                V2Error(self.currentDebugContext(),"格式不正确").logError()
            }
            self.refreshControl?.endRefreshing()
        })
    }
    
    private func addRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(DailyHotViewController.loadData), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(self.refreshControl!)
    }
}


// MARK: - 3DTouch
extension DailyHotViewController: UIViewControllerPreviewingDelegate{
    
    func previewingContext(previewingContext: UIViewControllerPreviewing,var viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        // location fix
        location = self.view.convertPoint(location, toView: self.tableView)
        
        guard let indexPath = tableView.indexPathForRowAtPoint(location), _ = tableView.cellForRowAtIndexPath(indexPath) else {
            return nil
        }
        
        guard let topicViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SID_TopicViewController") as? TopicViewController else {
            return nil
        }
        
        topicViewController.topicInfo = self.topics[indexPath.row]
        let cellFrame = tableView.cellForRowAtIndexPath(indexPath)!.frame
        previewingContext.sourceRect = view.convertRect(cellFrame, fromCoordinateSpace: tableView)
        
        return topicViewController
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        self.showViewController(viewControllerToCommit, sender: nil)
    }
}







