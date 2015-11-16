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


class BaseApiManager: ApiManagerProtocol, RequestParamsValidator {
    var methodName: String
    var requestMethod: HttpRequestMethod
    var baseUrl = V2EXBaseUrl
    var requestParams: [String: AnyObject]?
    var requestHeaders: [String: String]?
    
    init(methodName: String, requestType: HttpRequestMethod) {
        self.methodName = methodName
        self.requestMethod = requestType
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

        Alamofire.request(method, methodName, parameters: requestParams, encoding: .URL, headers: requestHeaders)
    }
}











































