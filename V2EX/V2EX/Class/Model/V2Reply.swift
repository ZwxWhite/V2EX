//
//  V2Replies.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/24.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import Foundation
import SwiftyJSON

class V2Reply {
    
    var id: Int?
    var thanks: Int?
    var content: String?
    var content_rendered: String?
    var member: V2Member?
    var created: Int?
    var last_modified: Int?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.thanks = json["thanks"].int
        self.content = json["content"].string
        self.content_rendered = json["content_rendered"].string
    }
}
