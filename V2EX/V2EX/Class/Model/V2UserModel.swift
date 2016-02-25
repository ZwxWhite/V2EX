//
//  V2UserModel.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/11.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

/*
    "status": "found",
    "id": 93908,
    "url": "http://www.v2ex.com/member/Zero24",
    "username": "Zero24",
    "website": "",
    "twitter": "",
    "psn": "",
    "github": "",
    "btc": "",
    "location": "",
    "tagline": "",
    "bio": "",
    "avatar_mini": "//cdn.v2ex.co/avatar/6cd4/8fb7/93908_mini.png?m=1423721123",
    "avatar_normal": "//cdn.v2ex.co/avatar/6cd4/8fb7/93908_normal.png?m=1423721123",
    "avatar_large": "//cdn.v2ex.co/avatar/6cd4/8fb7/93908_large.png?m=1423721123",
    "created": 1422263607
*/

class V2UserModel: Object {
    
    
    dynamic var id = 0
    var created = RealmOptional<Int>(nil)
    
    dynamic var status: String? = nil
    dynamic var url: String? = nil
    dynamic var username: String? = nil
    dynamic var website: String? = nil
    dynamic var twitter: String? = nil
    dynamic var psn: String? = nil
    dynamic var github: String? = nil
    dynamic var btc: String? = nil
    dynamic var location: String? = nil
    dynamic var tagline: String? = nil
    dynamic var bio: String? = nil
    dynamic var avatar_mini: String? = nil
    dynamic var avatar_normal: String? = nil
    dynamic var avatar_large: String? = nil
    
    var logined: Bool {
        get {
            return (self.id != 0);
        }
    }
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    override class func primaryKey() -> String {
        return "id"
    }

}

extension V2UserModel {
    func setupWithJson(json: JSON) {

        self.id            = json["id"].int!
        self.created.value = json["created"].int
        self.status        = json["status"].string
        self.url           = json["url"].string
        self.username      = json["username"].string
        self.website       = json["website"].string
        self.twitter       = json["twitter"].string
        self.psn           = json["psn"].string
        self.github        = json["github"].string
        self.btc           = json["btc"].string
        self.location      = json["location"].string
        self.tagline       = json["tagline"].string
        self.bio           = json["bio"].string
        self.avatar_mini   = json["avatar_mini"].string
        self.avatar_normal = json["avatar_normal"].string
        self.avatar_large  = json["avatar_large"].string
    }
}
