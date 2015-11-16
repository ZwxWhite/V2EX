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
class DailyHotViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var topicsArray = Array<V2Topics>()
    
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
            try BaseApiManager(methodName: "a", requestType: .Get).start()
        } catch HttpRequestErrorType.NoNetWork{

        } catch {
            
        }
        
        
        
        Alamofire.request(.GET, "https://www.v2ex.com/api/topics/hot.json").responseJSON { (responseObject: Response) -> Void in
            
            // 网络错误
            if let error = responseObject.result.error {
                print(error)
            }
        
            else {
                if let responseArray = responseObject.result.value as! NSArray? {
                    for dictionary in responseArray {
                        
                        
                    }
                }
            }
            
        }
    }
}







