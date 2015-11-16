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
        
    }
    
    func requestFailed(error: NSError) {
        
    }
}







