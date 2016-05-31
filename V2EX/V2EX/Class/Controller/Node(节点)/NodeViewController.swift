//
//  NodeViewController.swift
//  V2EX
//
//  Created by wenxuan.zhang on 15/11/12.
//  Copyright © 2015年 张文轩. All rights reserved.
//  节点

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

class NodeViewController: UICollectionViewController {

    var nodes = [V2NodeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadNodes()
        
        if let flowLayout = self.collectionView!.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSizeMake(1, 1)
            flowLayout.minimumLineSpacing = 5
        }
        
        self.collectionView?.contentInset = UIEdgeInsetsMake(0, 10, 10, 10)
    }
}



// MARK: -
extension NodeViewController {
    
    private func loadNodes() {
        request(.GET, v2exBaseUrl+"/api/nodes/all.json", parameters: nil, encoding: .URL, headers: nil).responseJSON { (response) -> Void in
            switch response.result {
            case .Success(let responseResult):
                if let responseArray = responseResult as? NSArray {
                    for dictionary in responseArray {
                        let node = V2NodeModel(json: JSON(dictionary))
                        self.nodes.append(node)
                    }
                }
                let cache = NSURLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
                NSURLCache.setSharedURLCache(cache)
                self.collectionView?.reloadData()
            case .Failure(let error):
                printLog(error)
            }
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nodes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NodeCollectionCell", forIndexPath: indexPath)
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = self.nodes[indexPath.row].title
        return cell
    }
    
    
}






