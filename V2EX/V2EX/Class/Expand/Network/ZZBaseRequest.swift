//
//  ZZBaseRequest.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/2.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Alamofire

protocol ZZRequestProtocol {
    func requestFinish(response: Response<AnyObject, NSError>)
    func requestFailed(error: NSError)
}





class ZZBaseRequest {
    
    var delegate: ZZRequestProtocol?
    
    var manager: Manager!
    
    var method: Method = .GET
    
    var requestUrl: String = ""
    
    var baseUrl: String = V2EXBaseUrl
    
    var parameters: [String: AnyObject]?
    
    var encoding: ParameterEncoding = .URL
    
    var headers: [String: String]?
    
    var request: Request?
    
    func start() {
        request = ZZNetworkAgent.sharedInstance.addRequest(self)
    }
}





