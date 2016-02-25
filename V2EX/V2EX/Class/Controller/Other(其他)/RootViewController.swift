//
//  RootViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import RealmSwift

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(v2Realm.objects(TestModel))
        
        try! v2Realm.write { () -> Void in
            let model = TestModel()
            model.optionValue = "hello"
            model.age.value = 20
            v2Realm.add(model)
        }
        
        print(v2Realm.objects(TestModel))

    }
}


class TestModel: Object {
    
    dynamic var optionValue: String? = nil
    
    let age = RealmOptional<Int>(nil)
}