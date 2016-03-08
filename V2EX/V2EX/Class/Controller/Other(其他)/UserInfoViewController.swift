//
//  UserInfoViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/3/7.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserInfoViewController: UIViewController {
    
    var username: String?
    var user: V2UserModel?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = username
    }
    
    private func loadData() {
        guard let username = username where username.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 else { return }
        
        request(.GET, "https://www.v2ex.com/api/members/show.json", parameters: ["username": username], encoding: .URL, headers: nil).responseJSON { (response) -> Void in
            switch response.result {
            case .Success(let responseJson):
                self.user = V2UserModel()
                self.user?.setupWithJson(JSON(responseJson))
                self.tableView.reloadData()
            case .Failure(let error):
                printLog(error)
            }
        }
    }
}


extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberInfoHeaderCell") as! MemberInfoHeaderCell
        
        if let avatarImageURL = user?.avatar_normal where avatarImageURL.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
            let avatarImageView = cell.contentView.viewWithTag(1000) as! UIImageView
            avatarImageView.kf_setImageWithURL(NSURL(string: v2exHttps(true) + avatarImageURL)!, placeholderImage: nil)
        }
        
        if let index = user?.id, _ = username where index > 0 {
            let indexLabel = cell.contentView.viewWithTag(1001) as! UILabel
            indexLabel.text = username! + " " + "V2EX 第 \(index) 号会员"
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
}