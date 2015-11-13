//
//  V2Topics.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/13.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Foundation


struct V2Topics {
    
    var id: String
    var title: String
    var url: String
    var content: String
    var content_rendered: String
    var replies: String
    var member: V2Member
    var node: V2Node
    var created: String
    var last_modified: String
    var last_touched: String
    
    init(id: String, title: String, url: String, content: String, content_rendered: String, replies: String, member: V2Member, node: V2Node, created: String, last_modified: String, last_touched: String) {
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
}



struct V2Member {
    var id: String
    var username: String
    var tagline: String
    var avatar_mini: String
    var avatar_normal: String
    var avatar_large: String
    
    init(id: String, username: String, tagline: String, avatar_mini: String, avatar_normal: String, avatar_large: String) {
        self.id = id
        self.username = username
        self.tagline = tagline
        self.avatar_mini = avatar_mini
        self.avatar_normal = avatar_normal
        self.avatar_large = avatar_large
    }
}



struct V2Node {
    var id: String
    var name: String
    var title: String
    var title_alternative: String
    var url: String
    var topics: String
    var avatar_mini: String
    var avatar_normal: String
    var avatar_large: String
    
    
    init(id: String, name: String, title: String, title_alternative: String, url: String, topics: String, avatar_mini: String, avatar_normal: String, avatar_large: String) {
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
}



