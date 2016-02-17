//
//  V2Topics.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/13.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Foundation


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
    
    init(id: Int, title: String, url: String, content: String, content_rendered: String, replies: Int, member: V2Member, node: V2Node, created: Int, last_modified: Int, last_touched: Int) {
        self.id = id
        self.title = title
        self.url = url
        self.content = content
        self.content_rendered = content_rendered
        self.replies = replies
        self.member = member
        self.node = node
        self.created = created
        self.last_modified = last_modified
        self.last_touched = last_touched
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["id"] as? Int
        self.title = dictionary["title"] as? String
        self.url = dictionary["url"] as? String
        self.content = dictionary["content"] as? String
        self.content_rendered = dictionary["content_rendered"] as? String
        self.replies = dictionary["replies"] as? Int
        self.member = V2Member(dictionary: (dictionary["member"] as? NSDictionary)!)
        self.node = V2Node(dictionary: (dictionary["node"] as? NSDictionary)!)
        self.created = dictionary["created"] as? Int
        self.last_modified = dictionary["last_modified"] as? Int
        self.last_touched = dictionary["last_touched"] as? Int
    }
}



class V2Member {
    var id: Int?
    var username: String?
    var tagline: String?
    var avatar_mini: String?
    var avatar_normal: String?
    var avatar_large: String?
    
    init(id: Int, username: String, tagline: String, avatar_mini: String, avatar_normal: String, avatar_large: String) {
        self.id = id
        self.username = username
        self.tagline = tagline
        self.avatar_mini = avatar_mini
        self.avatar_normal = avatar_normal
        self.avatar_large = avatar_large
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["id"] as? Int
        self.username = dictionary["username"] as? String
        self.tagline = dictionary["tagline"] as? String
        self.avatar_mini = dictionary["avatar_mini"] as? String
        self.avatar_normal = dictionary["avatar_normal"] as? String
        self.avatar_large = dictionary["avatar_large"] as? String
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
    
    
    init(id: Int, name: String, title: String, title_alternative: String, url: String, topics: Int, avatar_mini: String, avatar_normal: String, avatar_large: String) {
        self.id = id
        self.name = name
        self.title = title
        self.title_alternative = title_alternative
        self.url = url
        self.topics = topics
        self.avatar_mini = avatar_mini
        self.avatar_normal = avatar_normal
        self.avatar_large = avatar_large
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["id"] as? Int
        self.name = dictionary["name"] as? String
        self.title = dictionary["title"] as? String
        self.title_alternative = dictionary["title_alternative"] as? String
        self.url = dictionary["url"] as? String
        self.topics = dictionary["topics"] as? Int
        self.avatar_mini = dictionary["avatar_mini"] as? String
        self.avatar_normal = dictionary["avatar_normal"] as? String
        self.avatar_large = dictionary["avatar_large"] as? String
    }
}




