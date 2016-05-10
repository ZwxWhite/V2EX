//
//  V2NodeModel.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/1.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class V2NodeModel: Object {
    
    var id = RealmOptional<Int>(nil)
    var created = RealmOptional<Int>(nil)
    var topics = RealmOptional<Int>(nil)
    var firstCharacter: String? {
        return self.name?.firstCharacter()
    }

    dynamic var name: String? = nil
    dynamic var url: String? = nil
    dynamic var title: String? = nil
    dynamic var title_alternative: String? = nil
    dynamic var header: String? = nil
    dynamic var footer: String? = nil
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.id.value = json["id"].int
        self.topics.value = json["topics"].int
        self.created.value = json["created"].int
        self.name = json["name"].string
        self.url = json["url"].string
        self.title = json["title"].string
        self.title_alternative = json["title_alternative"].string
        self.header = json["header"].string
        self.footer = json["footer"].string
    }
}
