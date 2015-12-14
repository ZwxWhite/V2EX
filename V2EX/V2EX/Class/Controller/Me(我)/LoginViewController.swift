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
        
        if usernameTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 ||
            passwordTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                return
        }
        
        Alamofire.request(.GET, "http://www.v2ex.com/signin").responseString { (response) -> Void in
            switch response.result {
            case.Success(let htmlString):
                // 获取htmlString并解析
                let jiDoc = Ji(htmlString: htmlString, encoding: NSUTF8StringEncoding)
                let nodes = jiDoc?.xPath("//body//input")
                for index in 0...nodes!.count-1 {
                    if nodes![index].attributes["name"] == "once" {
                        if let once = nodes![index].attributes["value"] {
                            self.loginWithInfo(once)
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
    
    func loginWithInfo(once: String) {
        // login
        let username = usernameTextField.text
        let request = LoginRequest(username: username, password: self.passwordTextField.text, once: once)
        request.start()?.responseData({ (response) -> Void in
            switch response.result {
            case .Success(let responseData):
                let htmlString = String(data: responseData, encoding: NSUTF8StringEncoding)
                if htmlString?.rangeOfString("/notifications") != nil {
                    self.getUserInfo(username!)
                } else {
                    print("登录失败")
                }
            case .Failure(let error):
                print(error)
            }
        })
    }
    
    func getUserInfo(username: String) {
        let request = UserInfoRequest(username :username)
        request.start()?.responseJSON(completionHandler: { (response) -> Void in
            switch response.result{
            case .Success(let responseJson):
                let user = V2UserModel(dictionary: responseJson as! [String : AnyObject])
                try! v2Realm.write({ () -> Void in
                    v2Realm.add(user)
                })
                
                print(user.username)
                self.dismissViewControllerAnimated(true, completion: nil)
            case .Failure(let error):
                print(error)
            }
        })
    }
    
    
    @IBAction func dissmiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}





