//
//  LoginViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/8.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import Alamofire
import Ji

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

}


extension LoginViewController {
    
    @IBAction func login() {
        
        Alamofire.request(.GET, "http://www.v2ex.com/signin").responseString { (response) -> Void in
            switch response.result {
            case.Success(let htmlString):
                
                // 获取htmlString并解析
                let jiDoc = Ji(htmlString: htmlString, encoding: NSUTF8StringEncoding)
                let nodes = jiDoc?.xPath("//body//input")
                for index in 0...nodes!.count-1 {
                    if nodes![index].attributes["name"] == "once" {
                        if let once = nodes![index].attributes["value"] {
                            // login
                            let request = LoginRequest(username: self.usernameTextField.text, password: self.passwordTextField.text, once: once)
                            request.start()?.responseData({ (response) -> Void in
                                switch response.result {
                                case .Success(let responseData):
                                    let htmlString = String(data: responseData, encoding: NSUTF8StringEncoding)
                                    if htmlString?.rangeOfString("/notifications") != nil {
                                        self.dismissViewControllerAnimated(true, completion: nil)
                                    } else {
                                        print("登录失败")
                                    }
                                case .Failure(let error):
                                    print(error)
                                }
                            })
                        } else {
                            print("登录失败");
                        }
                        
                    }
                }
                
            case.Failure(let error):
                print(error)
            }
        }
    }
}
