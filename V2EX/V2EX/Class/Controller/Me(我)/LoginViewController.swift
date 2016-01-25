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

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func dissmiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func hideKeyboard() {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.hideKeyboard()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.login()
        return true
    }
    
}


extension LoginViewController {
    
    @IBAction func login() {
        
        if usernameTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 ||
            passwordTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                return
        }
        
        for cookie in NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies! {
            NSHTTPCookieStorage.sharedHTTPCookieStorage().deleteCookie(cookie)
        }
        
        Alamofire.request(.GET, v2exBaseUrl + "/signin").responseString { (response) -> Void in
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
                            printLog("登录失败");
                        }
                    }
                }
            case.Failure(let error):
                printLog(error)
            }
        }
    }
    
    func loginWithInfo(once: String) {
        // login
        let username = usernameTextField.text
        let request = LoginRequest(username: username, password: self.passwordTextField.text, once: once)
        request.start()?.responseString(completionHandler: { (response) -> Void in
            switch response.result {
            case .Success(let responseString):
                printLog(responseString)
                if responseString.containsString("/notifications") {
                    self.getUserInfo(username!)
                } else {
                    printLog("登录失败")
                }
            case .Failure(let error):
                printLog(error)
            }
        })
    }
    
    func getUserInfo(username: String) {
        let request = UserInfoRequest(username :username)
        request.start()?.responseJSON(completionHandler: { (response) -> Void in
            switch response.result{
            case .Success(let responseJson):
                let user = V2UserModel()
                print(responseJson as! [String: AnyObject])
                user.setupWithDictionary(responseJson as! [String: AnyObject])
                try! v2Realm.write({ () -> Void in
                    v2Realm.add(user, update: true)
                })
                self.dismissViewControllerAnimated(true, completion: nil)
            case .Failure(let error):
                printLog(error)
            }
        })
    }
}





