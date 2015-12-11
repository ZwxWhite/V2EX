//
//  LoginRequest.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/10.
//  Copyright © 2015年 张文轩. All rights reserved.
//


class LoginRequest: ZZBaseRequest {
    
    convenience init(username: String?, password: String?, once: String?) {
        self.init()
        requestUrl = "/signin"
        method = .POST
        
        parameters = [String: String]()
        parameters!["once"] = once
        parameters!["next"] = "/"
        if let usernameValue = username {
            parameters!["u"] = usernameValue
        }
        if let passwordValue = password {
            parameters!["p"] = passwordValue
        }
        
        headers = ["Referer":"http://v2ex.com/signin"]
    }
}

