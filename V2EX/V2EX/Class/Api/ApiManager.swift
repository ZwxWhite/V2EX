//
//  DailyHotApiManager.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/16.
//  Copyright © 2015年 张文轩. All rights reserved.
//


// 今日热议
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


// 分类
class CategoryApiManager: BaseApiManager {

    var tab: String! {
        didSet{
            self.requestParams = ["tab":tab]
        }
    }
    
    override var baseUrl: String {
        return "https://www.v2ex.com"
    }
    
}



















