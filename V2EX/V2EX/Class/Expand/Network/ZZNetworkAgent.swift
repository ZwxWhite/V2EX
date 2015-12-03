//
//  ZZNetworkAgent.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/2.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Alamofire
import ReachabilitySwift

final class ZZNetworkAgent {
    
    // 获取单例
    static let sharedInstance = ZZNetworkAgent()
    
    
    func addRequest(request: ZZBaseRequest) {
        
        // 判断网络状态
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            request.delegate?.requestFailed(Error.errorWithCode(7000, failureReason: "网络未连接"))
            return
        }
        reachability.whenUnreachable = { reachability in
            request.delegate?.requestFailed(Error.errorWithCode(7000, failureReason: "网络未连接"))
            return
        }
        
        Alamofire.request(request.method, buildRequestUrl(request), parameters: request.parameters, encoding: request.encoding, headers: request.headers)
    }
    
    private func buildRequestUrl(request: ZZBaseRequest) -> String {
        
        if let detailUrl = request.requestUrl {
            if detailUrl.hasPrefix("http") {
                return detailUrl
            } else {
                return String(request.baseUrl.appendContentsOf(detailUrl))
            }
        } else {
            return request.baseUrl
        }
    }
}


