//
//  DailyHotApiManager.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/16.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Alamofire


// 今日热议
class DailyHotApiManager: BaseApiManager {
    
    override var methodName:String {
        get{
            return "/api/topics/hot.json"
        }
        set{
            self.methodName = newValue
        }
    }
    
    override var requestMethod: HttpRequestMethod {
        get{
            return HttpRequestMethod.Get
        }
        set{
            self.requestMethod = newValue
        }
    }
}


// 分类
class CategoryApiManager: BaseApiManager {

    var tab: String! {
        didSet{
            self.requestParams = ["tab":tab]
        }
    }
    
    override func startRequest() {
        
        var method : Method
        switch requestMethod {
        case .Get: method = .GET
        case .Post:method = .POST
        }
        
        self.request = manager.request(method, baseUrl+methodName, parameters: requestParams, encoding: ParameterEncoding.URL, headers: requestHeaders).responseJSON { response in
            switch response.result {
            case .Success(_):
                if let delegate = self.delegate {
                    delegate.requestFinish(response)
                }
            case .Failure(let error):
                if let delegate = self.delegate {
                    delegate.requestFailed(error)
                }
            }
        }
    }
    
}



















