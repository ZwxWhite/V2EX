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
class DailyHotViewController: BaseViewController,Contextualizable,ApiRequestCallBack {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var apiManager = DailyHotApiManager()
    
    var topics = [V2Topics]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "今日热议"
        loadData()
    }
}



// MARK: LoadData
extension DailyHotViewController {
    func loadData() {
        do {
            apiManager.delegate = self
            try apiManager.start()
        } catch HttpRequestErrorType.NoNetWork{
            print(V2Error(currentDebugContext(),"网络不通").reason)
        } catch {
            print(V2Error(currentDebugContext(),"网络不通").source)
        }
    }
    
    func requestFinish(response: Response<AnyObject, NSError>) {
        if let result = response.result.value as? NSArray {
            for dictionary in result {
                topics.append(V2Topics(dictionary: dictionary as! NSDictionary))
            }
            tableView.reloadData()
        } else {
            print(V2Error(currentDebugContext(),"格式不正确"))
        }
        
    }
    
    func requestFailed(error: NSError) {
        
    }
}







