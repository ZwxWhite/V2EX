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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
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
}


// MARK: - LoadData
extension CategoryItemViewController {
    private func loadData() {
        
        self.categoryTab = "apple"
        request(.GET, v2exBaseUrl, parameters: ["tab":self.categoryTab], encoding: .URL, headers: nil).responseString { (response) -> Void in
            switch response.result{
            case .Success(let responseString):
                self.responseConfigWith(responseString)
            case .Failure(let error):
                V2Error(self.currentDebugContext(),error.description).logError()
            }
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
                
                var topicModel = V2TopicModel()
                // 获取tdNode
                let tdNodes = trNode.childrenWithName("td")
                for tdNode in tdNodes {
                    if let contentString = tdNode.rawContent {
                        if contentString.containsString("class=\"avatar\"") {
                            if let userIdNode = tdNode.firstChildWithName("a") {
                                topicModel.userName = userIdNode.attributes["href"]?.componentsSeparatedByString("/").last
                                print(topicModel.userName)
                            }
                        }
                    }
                }
            }
        }
    }
}





