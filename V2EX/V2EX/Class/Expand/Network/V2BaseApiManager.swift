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
    var methodName: String
    var requestMethod: HttpRequestMethod
    var baseUrl = V2EXBaseUrl
    var requestParams: [String: AnyObject]?
    var requestHeaders: [String: String]?
    var timeoutInterval = V2TimeoutInterval
    weak var delegate: ApiRequestCallBack?
    
    private var manager: Manager
    private var request: Request?
    
    
    init(methodName: String, requestType: HttpRequestMethod) {
        self.methodName = methodName
        self.requestMethod = requestType
        
        // manager
        let urlSessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSessionConfig.timeoutIntervalForRequest = timeoutInterval
        urlSessionConfig.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        self.manager = Manager(configuration: urlSessionConfig)
    }
    
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
    
    
    func cancel() {
        if let request = self.request {
            request.cancel()
        } else {
            print("no request")
        }
    }
}











































