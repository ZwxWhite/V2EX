//
//  DailyHotControllerService.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/4.
//  Copyright © 2015年 张文轩. All rights reserved.
//


class DailyHotControllerService {
    
    var dailyHotRequest: DailyHotRequest = DailyHotRequest()
    
    func loadData() {
        if let request = dailyHotRequest.start() {
            request.responseJSON(completionHandler: { (reponse) -> Void in
                
            })
        } else {
            
        }
    }
}