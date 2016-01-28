//
//  CategorieItemViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/18.
//  Copyright © 2015年 张文轩. All rights reserved.
//

import UIKit
import Alamofire
import Ji


class CategoryItemViewController: UIViewController, Contextualizable {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoryTab: String!
    private lazy var topics = [V2TopicModel]()
    private var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        addRefresh()
    }
}



// MARK: - UITableViewDelegate & UITableViewDataSource
extension CategoryItemViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let topicCell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as? V2TopicCell {
            let topicViewModel = topics[indexPath.row]
            topicCell.topicViewModel = topicViewModel
            return topicCell
        }
        V2Error(currentDebugContext(),"cell error").logError()
        return UITableViewCell()
    }
    
    private func addRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(self.refreshControl!)
    }
}


// MARK: - LoadData
extension CategoryItemViewController {
    func loadData() {
        request(.GET, v2exBaseUrl, parameters: ["tab":self.categoryTab], encoding: .URL, headers: nil).responseString { (response) -> Void in
            switch response.result{
            case .Success(let responseString):
                self.topics.removeAll()
                self.responseConfigWith(responseString)
            case .Failure(let error):
                V2Error(self.currentDebugContext(),error.description).logError()
            }
            self.refreshControl?.endRefreshing()
        }
    }
    
    
    /**
        解析html 至cell node
     */
    private func responseConfigWith(result: String) {
        let jiDoc = Ji(htmlString: result, encoding: NSUTF8StringEncoding)
        if let wrapperNode = jiDoc?.xPath("//body")?.first?.childrenWithAttributeName("id", attributeValue: "Wrapper").first {
            if let contentNode = wrapperNode.childrenWithAttributeName("class", attributeValue: "content").first {
                if let mainNode = contentNode.childrenWithAttributeName("id", attributeValue: "Main").first {
                    if let boxNode = mainNode.childrenWithAttributeName("class", attributeValue: "box").first {
                        let cellNodes = boxNode.childrenWithAttributeName("class", attributeValue: "cell item")
                        self.configWithCellNodes(cellNodes)
                    } else {
                        V2Error(self.currentDebugContext(),"解析错误").logError()
                    }
                } else {
                    V2Error(self.currentDebugContext(),"解析错误").logError()
                }
            } else {
                V2Error(self.currentDebugContext(),"解析错误").logError()
            }
        } else {
            V2Error(self.currentDebugContext(),"解析错误").logError()
        }
    }
    
    /**
        将cell node 解析为model
    */
    private func configWithCellNodes(cellNodes: [JiNode]) {
        for cellNode in cellNodes {
            if let trNode = cellNode.childrenWithName("table").first?.childrenWithName("tr").first {
                // 获取tdNode
                let tdNodes = trNode.childrenWithName("td")
                var topicModel = V2TopicModel()

                // 遍历
                for tdNode in tdNodes {
                    if let contentString = tdNode.rawContent {
                        
                        // 用户信息节点
                        if contentString.containsString("class=\"avatar\"") {
                                if let userIdNode = tdNode.firstChildWithName("a") {
                                // 获取用户名
                                topicModel.userName = userIdNode.attributes["href"]?.componentsSeparatedByString("/").last
                                
                                // 获取头像
                                let imgNode = userIdNode.childrenWithName("img").first
                                if let avatarString = imgNode?.attributes["src"] {
                                    topicModel.avatarImageString = "https:" + avatarString
                                }
                            }
                        }
                        
                        // 标题节点
                        if contentString.containsString("class=\"item_title\"") {
                            if let titleNode = tdNode.childrenWithAttributeName("class", attributeValue: "item_title").first?.childrenWithName("a").first {
                                // 获取标题
                                topicModel.title = titleNode.content
                                
                                // 获取回复数
                                topicModel.replies = titleNode.attributes["href"]?.componentsSeparatedByString("reply").last
                            }
                            
                            if let infoNode = tdNode.childrenWithAttributeName("class", attributeValue: "small fade").first {
                                
                                if let nodeNode = infoNode.childrenWithName("a").first {
                                    // 获取节点
                                    topicModel.node = nodeNode.content! + "   "
                                }
                                
                                if infoNode.rawContent?.containsString("href") == false {
                                    // 回复时间
                                    topicModel.lastModified = infoNode.content
                                }
                                
                                if infoNode.rawContent?.containsString("最后回复") == true || infoNode.rawContent?.containsString("前") == true {
                                    let components = infoNode.content?.componentsSeparatedByString("  •  ")
                                    
                                    var dateString: String
                                    if components?.count > 2 {
                                        dateString = components![2]
                                    } else {
                                        dateString = (infoNode.content?.stringByReplacingOccurrencesOfString("  •  (.*?)$", withString: ""))!
                                    }
                                    
                                    let stringArray = dateString.componentsSeparatedByString(" ")
                                    if stringArray.count > 1 {
                                        var unitString = ""
                                        let index = stringArray[1].startIndex.advancedBy(1)
                                        let subString = stringArray[1].substringToIndex(index)
                                        if subString == "分" {
                                            unitString = "分钟前"
                                        }
                                        if subString == "小" {
                                            unitString = "小时前"
                                        }
                                        if subString == "天" {
                                            unitString = "天前"
                                        }
                                        dateString = stringArray.first! + unitString
                                    } else {
                                        dateString = "刚刚"
                                    }
                                    topicModel.lastModified = dateString
                                }
                            }
                        }
                    }
                }
                self.topics.append(topicModel)
                self.tableView.reloadData()
            } else {
                V2Error(self.currentDebugContext(),"解析错误").logError()
            }
        }
    }
}





