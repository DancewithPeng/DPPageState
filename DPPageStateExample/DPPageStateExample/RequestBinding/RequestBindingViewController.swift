//
//  RequestBindingViewController.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/9.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
import DPLog

class RequestBindingViewController: StateViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var request: Alamofire.DataRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadRequest()
    }
    
    override func emptyViewDidTap(_ tapGesture: UITapGestureRecognizer) {
        reloadRequest()
    }
    
    override func errorViewDidTap(_ tapGesture: UITapGestureRecognizer) {
        reloadRequest()
    }
    
    private func reloadRequest() {
        
        request = Alamofire.request("https://www.apple.com").responseString { (response) in
            if let value = response.value {
                self.webView.loadHTMLString(value, baseURL: nil)
                self.pageState = .normal
                LogInfo(value)
            } else if let error = response.error {
                self.pageState = .error(error)
                LogError(error)
            }
        }
        
        pageState = .loading(request?.progress)
    }
}
