//
//  V2BaseApiManager.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/16.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Alamofire

// MARK: Enum
/**
    请求类型

    - Get:  Get请求
    - Post: Post请求
*/
enum HttpRequestMethod {
    case Get
    case Post
}


/**
     网络错误类型
     
     - NoContent:   返回内容不符
     - ParamsError: 参数格式不符
     - Timeout:     超时
     - NoNetWork:   无网络
 */
enum HttpRequestErrorType: ErrorType {
    case NoContent
    case ParamsError
    case Timeout
    case NoNetWork
}


// MARK: Protocol
protocol ApiManagerProtocol {
    var methodName: String { get }
    var requestMethod: HttpRequestMethod { get }
}

protocol RequestParamsValidator {
    
}
extension RequestParamsValidator {
    func requestParamsCorrect() -> Bool {
        return true
    }
}


protocol ApiRequestCallBack: NSObjectProtocol {
    func requestFinish(response: Response<AnyObject, NSError>)
    func requestFailed(error: NSError)
}


class BaseApiManager: ApiManagerProtocol, RequestParamsValidator {
    
    /// 服务器地址
    var baseUrl: String {
        return V2EXBaseUrl
    }
    
    /// 请求api
    var methodName: String {
        return ""
    }
    
    /// 请求方式
    var requestMethod: HttpRequestMethod {
        return HttpRequestMethod.Get
    }
    
    /// 请求参数
    var requestParams: [String: AnyObject]?
    
    /// 请求头
    var requestHeaders: [String: String]?
    
    /// 超时时间
    var timeoutInterval = V2TimeoutInterval
    
    /// 回调代理
    weak var delegate: ApiRequestCallBack?
    
    /// 请求manager
    var manager: Manager
    
    /// 请求request
    var request: Request?
    

    init() {
        // manager
        let urlSessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSessionConfig.timeoutIntervalForRequest = timeoutInterval
        urlSessionConfig.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        self.manager = Manager(configuration: urlSessionConfig)
    }
    
    /**
         开始网络请求
         
         - throws: 错误类型
     */
    func start() throws {
        
        // 1.判断参数
        guard requestParamsCorrect() else {
            throw HttpRequestErrorType.ParamsError
        }
        
        // 2.判断网络
        guard networkReachability() else {
            throw HttpRequestErrorType.NoNetWork
        }
        
        // 3.发起请求
        startRequest()
    }
    
    func startRequest() {
        
        var method : Method
        switch requestMethod {
        case .Get: method = .GET
        case .Post:method = .POST
        }
        
        request = manager.request(method, baseUrl+methodName, parameters: requestParams, encoding: .URL, headers: requestHeaders).responseJSON { response in
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
    
    
    /**
        取消网络请求
     */
    func cancel() {
        if let request = self.request {
            request.cancel()
        } else {
            print("no request")
        }
    }
}











































