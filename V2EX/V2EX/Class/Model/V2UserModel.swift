//
//  V2UserModel.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/11.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Foundation
import RealmSwift

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
    
    dynamic var status = ""
    dynamic var id = NSNumber(integer: 0)
    dynamic var url = ""
    dynamic var username = ""
    dynamic var website = ""
    dynamic var twitter = ""
    dynamic var psn = ""
    dynamic var github = ""
    dynamic var btc = ""
    dynamic var location = ""
    dynamic var tagline = ""
    dynamic var bio = ""
    dynamic var avatar_mini = ""
    dynamic var avatar_normal = ""
    dynamic var avatar_large = ""
    dynamic var created = NSNumber(integer: 0)
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    override class func primaryKey() -> String {
        return "id"
    }

}

extension V2UserModel {
    func setupWithDictionary(dictionary: [String: AnyObject]) {
        self.setValuesForKeysWithDictionary(dictionary)
    }
}
