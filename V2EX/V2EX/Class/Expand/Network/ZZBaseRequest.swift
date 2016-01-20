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
    var method: Method
    
    /// baseUrl
    var baseUrl: String
    
    /// 请求url
    var requestUrl: String?
    
    /// 请求参数
    var parameters: [String: AnyObject]
    
    /// encoding
    var encoding: ParameterEncoding
    
    /// header
    var headers: [String: String]
    
    /// 请求的request
    var request: Request?
    
    func start() -> Request? {
        request = ZZNetworkAgent.sharedInstance.addRequest(self)
        return request
    }
    
    init() {
        self.method = .GET
        self.baseUrl = v2exBaseUrl
        self.parameters = [String: String]()
        self.headers = [String: String]()
        self.encoding = .URL
    }
}






