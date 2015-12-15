//
//  ZZBaseRequest.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/2.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Alamofire


class ZZBaseRequest {
    
    /// 请求方式
    var method: Method = .GET
    
    /// baseUrl
    var baseUrl: String {
        return v2exBaseUrl()
    }
    
    /// 请求url
    var requestUrl: String?
    
    /// 请求参数
    var parameters: [String: AnyObject]?
    
    /// encoding
    var encoding: ParameterEncoding = .URL
    
    /// header
    var headers: [String: String]?
    
    /// 请求的request
    var request: Request?
    
    func start() -> Request? {
        request = ZZNetworkAgent.sharedInstance.addRequest(self)
        return request
    }
}






