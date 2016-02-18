//
//  V2TopicModel.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/1/28.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import Ji

class V2TopicModel: Contextualizable {
    var avatarImageString: String?
    var title: String!
    var userName: String!
    var lastModified: String!
    var replies: String!
    var node: String!
    var id: Int?
    var created: NSDate?

    init () {
        
    }
    
    init(topic:V2Topic){
        if let modelAvatarImageString = topic.member?.avatar_normal {
            self.avatarImageString = "https:" + modelAvatarImageString
        } else {
            self.avatarImageString = nil
        }
        
        if let modelTitle = topic.title {
            self.title = modelTitle
        } else {
            self.title = ""
        }
        
        if let modelUserName = topic.member?.username {
            self.userName = modelUserName
        } else {
            self.userName = ""
        }
        
        if let modelLastTouched = topic.last_modified {
            
            let lastTouchedTime = NSTimeInterval(modelLastTouched)
            self.lastModified = relationshipOfDate(NSDate(), anotherDate: NSDate(timeIntervalSince1970: lastTouchedTime))
        } else {
            self.lastModified = ""
        }
        
        if let modelReplies = topic.replies {
            self.replies = String(modelReplies)
        } else {
            self.replies = "0"
        }
        
        if let modelNode = topic.node?.title {
            self.node = modelNode+"   "
        } else {
            self.node = ""
        }
        
        if let modelCreated = topic.created {
            let interval = NSTimeInterval(modelCreated)
            created = NSDate(timeIntervalSince1970: interval)
        }
        
        self.id = topic.id
    }
    
    /**
     解析html 至cell node
     */
    static func responseConfigWith(result: String) -> [V2TopicModel] {
        
        if let htmlJi = Ji(htmlString: result) {
            if let cellNode = htmlJi.xPath("//body/div[@id='Wrapper']/div[@class='content']/div[@id='Main']/div[@class='box']/div[@class='cell item']") {
                return self.configWithCellNodes(cellNode)
            }
        }
        return [V2TopicModel]()
    }
    
    /**
     将cell node 解析为model
     */
    static func configWithCellNodes(cellNodes: [JiNode]) -> [V2TopicModel] {
        var topics = [V2TopicModel]()
        for cellNode in cellNodes {
            if let trNode = cellNode.childrenWithName("table").first?.childrenWithName("tr").first {
                // 获取tdNode
                let tdNodes = trNode.childrenWithName("td")
                let topicModel = V2TopicModel()
                
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
                                
                                // 获取id
                                if let id = titleNode.attributes["href"]?.componentsSeparatedByString("#").first?.componentsSeparatedByString("/").last {
                                    topicModel.id = Int(id)
                                }
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
                topics.append(topicModel)
            } else {
                V2Error(__FILE__,"解析错误").logError()
            }
        }
        return topics
    }
}