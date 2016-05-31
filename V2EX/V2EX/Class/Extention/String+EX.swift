//
//  NSString+EX.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/5/10.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import Foundation


extension String {
    func firstCharacter() -> String? {
        //转成了可变字符串
        let str = NSMutableString(string: self)
        //先转换为带声调的拼音
        CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false)
        //再转换为不带声调的拼音
        CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
        //转化为大写拼音
        let pinYin = str.lowercaseString
        //获取并返回首字母
        return pinYin.substringToIndex(self.startIndex.advancedBy(1))
    }
}