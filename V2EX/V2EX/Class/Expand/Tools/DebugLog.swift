//
//  DebugLog.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/16.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import Foundation


protocol Contextualizable {
    
}

extension Contextualizable {
    func currentContext(file : String = __FILE__, function : String = __FUNCTION__, line : Int = __LINE__) -> String {
        return "\(file):\(function):\(line):\(self.dynamicType)"
    }
}


public struct V2Error: ErrorType {
    let source: String
    let reason: String
    
    public init(_ source: String = __FILE__, _ reason: String) {
        self.reason = reason
        self.source = source
    }
}





