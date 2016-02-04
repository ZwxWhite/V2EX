//
//  V2NodeModel.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/2/1.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import Foundation
import RealmSwift

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
}


extension V2NodeModel {
    func setupWithDictionary(dictionary: [String: AnyObject]) {
        self.setValuesForKeysWithDictionary(dictionary)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}




class V2NodeRecord: Object {
    dynamic var searchText: String?
}
