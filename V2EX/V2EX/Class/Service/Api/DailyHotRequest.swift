//
//  DailyHotRequest.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/4.
//  Copyright © 2015年 张文轩. All rights reserved.
//


class DailyHotRequest: ZZBaseRequest {
    
    override init() {
        super.init()
        
        self.requestUrl = "/api/topics/hot.json"
        self.method = .GET
        
    }
}

