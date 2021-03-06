//
//  ZZNetworkAgent.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/2.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Alamofire

final class ZZNetworkAgent {
    
    // 获取单例
    static let sharedInstance = ZZNetworkAgent()
    
    lazy private var requestsRecord = [Int: ZZBaseRequest]()
    
    func addRequest(request: ZZBaseRequest) -> Request {
//        // 添加至operation
//        let requestKey = buildRequestUrl(request).hash
//        requestsRecord[requestKey] = request
        
        // 发送网络请求,返回Request
        return Alamofire.request(request.method, buildRequestUrl(request), parameters: request.parameters, encoding: request.encoding, headers: request.headers)
    }
    
    private func buildRequestUrl(request: ZZBaseRequest) -> String {
        if let detailUrl = request.requestUrl {
            if detailUrl.hasPrefix("http") {
                return detailUrl
            } else {
                return String(request.baseUrl + (detailUrl))
            }
        } else {
            return request.baseUrl
        }
    }
}


