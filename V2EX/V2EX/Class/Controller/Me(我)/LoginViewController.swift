//
//  LoginViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/12/8.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
}


extension LoginViewController {
    
    @IBAction func login() {
        
        Alamofire.request(.GET, "http://www.v2ex.com/signin").responseString { (response) -> Void in
            if let responseString = response.result.value {

            }
        }
        
        
        let request = LoginRequest(username: usernameTextField.text, password: passwordTextField.text)
        request.start()?.responseData({ (response) -> Void in
            switch response.result {
            
            case .Success(let responseData):
                let htmlString = String(data: responseData, encoding: NSUTF8StringEncoding)
                if htmlString?.rangeOfString("/notifications") != nil {
                    print("login success")
                }
            case .Failure(let error):
                print(error)
            }
        })
    }
}
