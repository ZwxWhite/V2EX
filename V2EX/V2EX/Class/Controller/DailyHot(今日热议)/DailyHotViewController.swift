//
//  DailyHotViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//  今日热议

import UIKit
import Alamofire

// MARK: Life cycle
class DailyHotViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,Contextualizable,ApiRequestCallBack {

    @IBOutlet weak var tableView: UITableView! {
        didSet{
            self.tableView.tableFooterView = UIView()
        }
    }
    
    lazy var apiManager = DailyHotApiManager()
    
    var topics = [V2Topic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "今日热议"
        loadData()
    }
}

// MARK: 
extension DailyHotViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let topicCell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as? V2TopicCell {
            let topic = topics[indexPath.row]
            topicCell.topic = topic

            return topicCell
        }
        
        print(V2Error(currentDebugContext(),"cell error"))
        return UITableViewCell()
    }
}


// MARK: LoadData
extension DailyHotViewController {
    func loadData() {
        do {
            apiManager.delegate = self
            try apiManager.start()
        } catch HttpRequestErrorType.NoNetWork{
            print(V2Error(currentDebugContext(),"网络不通"))
        } catch HttpRequestErrorType.ParamsError{
            print(V2Error(currentDebugContext(),"参数错误"))
        } catch {
            
        }
    }
    
    func requestFinish(response: Response<AnyObject, NSError>) {
        if let result = response.result.value as? NSArray {
            for dictionary in result {
                topics.append(V2Topic(dictionary: dictionary as! NSDictionary))
            }
            tableView.reloadData()
        } else {
            print(V2Error(currentDebugContext(),"格式不正确"))
        }
        
    }
    
    func requestFailed(error: NSError) {
        
    }
}







