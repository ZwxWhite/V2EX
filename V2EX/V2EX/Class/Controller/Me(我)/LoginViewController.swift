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
import SwiftyJSON

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
                if let jiDoc = Ji(htmlString: htmlString, encoding: NSUTF8StringEncoding) {
                    
                    let once:String? = jiDoc.xPath("//*[@name='once'][1]")?.first?["value"]
                    print(jiDoc.xPath("//*[@id='Wrapper']/div/div[2]/div[1]"))
                    let usernameStr:String? = jiDoc.xPath("//*[@id='Wrapper']/div/div[3]/div[2]/div[@class='cell']/form/table/tr[1]/td[2]/input[@class='sl']")?.first?["name"]
                    let passwordStr:String? = jiDoc.xPath("//*[@id='Wrapper']/div/div[3]/div[2]/div[@class='cell']/form/table/tr[2]/td[2]/input[@class='sl']")?.first?["name"]
                    self.loginWithOnce(once,usernameKey: usernameStr,passwordKey: passwordStr)
                } else {
                    printLog("登录信息获取失败")
                }
                
            case.Failure(let error):
                printLog(error)
            }
        }
    }
    
    func loginWithOnce(once: String?, usernameKey: String?, passwordKey: String?) {

        guard let _ = once, username = self.usernameTextField.text, password = self.passwordTextField.text else { return }
        
        let request = LoginRequest(username: username, password: password, once: once, usernameKey: usernameKey, passwordKey: passwordKey)
        request.start()?.responseString(completionHandler: { (response) -> Void in
            switch response.result {
            case .Success(let htmlString):
                if htmlString.containsString("/notifications") {
                    self.getUserInfo(self.usernameTextField.text!)
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
                printLog(responseJson as! [String: AnyObject])
                user.setupWithJson(JSON(responseJson))
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





