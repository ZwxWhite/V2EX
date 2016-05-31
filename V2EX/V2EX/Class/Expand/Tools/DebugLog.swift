//
//  DebugLog.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/16.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Foundation


public protocol Contextualizable {
    
}

extension Contextualizable {
    func currentDebugContext(file : String = #file, function : String = #function, line : Int = #line) -> String {
        return "\(file):\(function):\(line):\(self.dynamicType)"  //dynamicType表达式来获取该实例在运行阶段的类型
    }
}


public struct V2Error: ErrorType {
    let source: String
    let reason: String
    
    public init(_ source: String = #file, _ reason: String) {
        self.reason = reason
        self.source = source
    }
    
    func logError() {
        print(self.description())
    }
}

extension V2Error {
    func description() -> String {
        return "Source:\(source) \n Reason:\(reason)"
    }
}




public func printLog<T>(message: T,
                    file: String = #file,
                  method: String = #function,
                    line: Int = #line){
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #else
    #endif
}



