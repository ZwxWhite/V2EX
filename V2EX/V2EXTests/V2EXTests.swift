//
//  V2EXTests.swift
//  V2EXTests
//
//  Created by wenxuan.zhang on 16/5/10.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import XCTest

class V2EXTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let str = "我的世界"
        print(str.firstCharactor())
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
