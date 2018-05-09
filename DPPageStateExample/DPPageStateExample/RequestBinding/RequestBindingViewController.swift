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

class RequestBindingViewController: StateViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var request: Alamofire.DataRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.request = Alamofire.request("https://www.baidu.com").responseString { (response) in
            if let value = response.value {
                self.webView.loadHTMLString(value, baseURL: nil)
                self.pageState = .normal
            } else if let error = response.error {
                self.pageState = .error(error)
            }
        }
        
        pageState = .loading(self.request?.progress)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}
