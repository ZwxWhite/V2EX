//
//  TopicContentCell.swift
//  V2EX
//
//  Created by wenxuan.zhang on 16/3/1.
//  Copyright © 2016年 张文轩. All rights reserved.
//

import UIKit
import KVOController

class TopicContentCell: UITableViewCell, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView! {
        didSet{
            webView.scrollView.scrollEnabled = false
            webView.delegate = self
        }
    }
    var contentHeightChanged : ((CGFloat) -> Void)?
    var contentHeight: CGFloat = 0
    var content: String? {
        didSet{
            if content == nil {
                return
            }
            if oldValue != content {
                webView.loadHTMLString(content!, baseURL: NSURL(string: v2exHttps(true) + "//"))
            }
        }
    }
    
    
    override func awakeFromNib() {
        self.KVOController.observe(self.webView!.scrollView, keyPath: "contentSize", options: [.New]) {
            [weak self] (observe, observer, change) -> Void in
            if let weakSelf = self {
                let size = change![NSKeyValueChangeNewKey] as! NSValue
                weakSelf.contentHeight = size.CGSizeValue().height;
                if let event = weakSelf.contentHeightChanged {
                    event(weakSelf.contentHeight)
                }
            }
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == .LinkClicked {
            if request.URLString.hasPrefix("http") {
                UIApplication.sharedApplication().openURL(request.URL!)
                return false
            }
        }
        return true
    }
}
