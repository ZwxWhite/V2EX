//
//  DailyHotRequest.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/4.
//  Copyright © 2015年 张文轩. All rights reserved.
//


class DailyHotRequest: ZZBaseRequest {
    
    override var requestUrl: String {
        get{
            return "/api/topics/hot.json"
        }
    }
}

