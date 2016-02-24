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
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var url = ""
    dynamic var title = ""
    dynamic var title_alternative = ""
    dynamic var topics = 0
    dynamic var header = ""
    dynamic var footer = ""
    dynamic var created = 0
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].int!
        self.topics = json["topics"].int!
        self.created = json["created"].int!
        self.name = json["name"].string!
        self.url = json["url"].string!
        self.title = json["title"].string!
        self.title_alternative = json["title_alternative"].string!
//        self.header = json["header"].string!
//        self.footer = json["footer"].string!
    }

    
}


class V2NodeRecord: Object {
    dynamic var searchText: String?
}
