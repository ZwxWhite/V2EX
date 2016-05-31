//
//  V2Topics.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/13.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Foundation
import SwiftyJSON

class V2Topic {
    
    var id: Int?
    var title: String?
    var url: String?
    var content: String?
    var content_rendered: String?
    var replies: Int?
    var member: V2Member?
    var node: V2Node?
    var created: Int?
    var last_modified: Int?
    var last_touched: Int?
    
    init(dictionary: NSDictionary) {
        self.id               = dictionary["id"] as? Int
        self.title            = dictionary["title"] as? String
        self.url              = dictionary["url"] as? String
        self.content          = dictionary["content"] as? String
        self.content_rendered = dictionary["content_rendered"] as? String
        self.replies          = dictionary["replies"] as? Int
        self.member           = V2Member(dictionary: (dictionary["member"] as? NSDictionary)!)
        self.node             = V2Node(dictionary: (dictionary["node"] as? NSDictionary)!)
        self.created          = dictionary["created"] as? Int
        self.last_modified    = dictionary["last_modified"] as? Int
        self.last_touched     = dictionary["last_touched"] as? Int
    }
    
    init(json:JSON) {
        self.id               = json["id"].int
        self.title            = json["title"].string
        self.url              = json["url"].string
        self.content          = json["content"].string
        self.content_rendered = json["content_rendered"].string
        self.replies          = json["replies"].int
        self.member           = V2Member(json: json["member"])
        self.node             = V2Node(json: json["node"])
        self.created          = json["created"].int
        self.last_modified    = json["last_modified"].int
        self.last_touched     = json["last_touched"].int
    }
}



class V2Member {
    var id: Int?
    var username: String?
    var tagline: String?
    var avatar_mini: String?
    var avatar_normal: String?
    var avatar_large: String?
    
    init(dictionary: NSDictionary) {
        self.id            = dictionary["id"] as? Int
        self.username      = dictionary["username"] as? String
        self.tagline       = dictionary["tagline"] as? String
        self.avatar_mini   = dictionary["avatar_mini"] as? String
        self.avatar_normal = dictionary["avatar_normal"] as? String
        self.avatar_large  = dictionary["avatar_large"] as? String
    }
    
    init(json:JSON) {
        self.id            = json["id"].int
        self.username      = json["username"].string
        self.tagline       = json["tagline"].string
        self.avatar_mini   = json["avatar_mini"].string
        self.avatar_normal = json["avatar_normal"].string
        self.avatar_large  = json["avatar_large"].string
    }
}



class V2Node {
    var id: Int?
    var name: String?
    var title: String?
    var title_alternative: String?
    var url: String?
    var topics: Int?
    var avatar_mini: String?
    var avatar_normal: String?
    var avatar_large: String?
    
    init(dictionary: NSDictionary) {
        self.id                = dictionary["id"] as? Int
        self.name              = dictionary["name"] as? String
        self.title             = dictionary["title"] as? String
        self.title_alternative = dictionary["title_alternative"] as? String
        self.url               = dictionary["url"] as? String
        self.topics            = dictionary["topics"] as? Int
        self.avatar_mini       = dictionary["avatar_mini"] as? String
        self.avatar_normal     = dictionary["avatar_normal"] as? String
        self.avatar_large      = dictionary["avatar_large"] as? String
    }
    
    init(json: JSON) {
        self.id                = json["id"].int
        self.name              = json["name"].string
        self.title             = json["title"].string
        self.title_alternative = json["title_alternative"].string
        self.url               = json["url"].string
        self.topics            = json["topics"].int
        self.avatar_mini       = json["avatar_mini"].string
        self.avatar_normal     = json["avatar_normal"].string
        self.avatar_large      = json["avatar_large"].string
    }
}




