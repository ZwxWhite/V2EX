//
//  TopicRequest.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/23.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit

class TopicRequest: ZZBaseRequest {
    
    convenience init(id: Int?) {
        self.init()
        
        self.requestUrl = "/api/topics/show.json"
        self.method = .GET
        
        if let topicID = id {
            parameters["id"] = topicID
        }
    }
}


class RepliesRequest: ZZBaseRequest {
    convenience init(topicID: Int?) {
        self.init()
        
        self.requestUrl = "/api/replies/show.json"
        if topicID != nil {
            parameters["topic_id"] = topicID
        }
    }
}
