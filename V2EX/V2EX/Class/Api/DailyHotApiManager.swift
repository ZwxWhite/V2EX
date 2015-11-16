//
//  DailyHotApiManager.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/16.
//  Copyright © 2015年 张文轩. All rights reserved.
//

class DailyHotApiManager: BaseApiManager {
    
    override var methodName:String {
        get{
            return "/api/topics/hot.json"
        }
        set{
            self.methodName = newValue
        }
    }
    
    override var requestMethod: HttpRequestMethod {
        get{
            return HttpRequestMethod.Get
        }
        set{
            self.requestMethod = newValue
        }
    }
}

