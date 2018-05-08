//
//  NetworkStateViewController.swift
//  DPPageStateControllerExample
//
//  Created by 张鹏 on 2018/5/7.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import Alamofire

class TestObj {
    deinit {
        print("go to die")
    }
    
    func hahah() {
        print("哈哈哈\(self)")
    }
}

class NetworkStateViewController: BaseViewController {
    
    let progress = Progress(totalUnitCount: 100)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        pageState = .initial("准备开始")
        DispatchQueue.global().asyncAfter(deadline: .now()+2) {
//            self.pageState = .empty("Hello Empty View")
//            self.pageState = .initial("啊啦啦啦啦啦啦")
            self.pageState = .loading(nil)
            
            DispatchQueue.global().asyncAfter(deadline: .now()+2) {
                self.pageState = .empty("没有数据哦")
            }
        }
        
        Alamofire.request("asdf").response { (response) in
            
        }
//
//        let request =
//        Alamofire.request("https://google.com").responseString { (response) in
//            if let str = response.value {
//                print(str)
//                self.pageState = .normal
//            } else if let error = response.error {
//                print(error)
//                self.pageState = .error(error)
//            }
//        }
//
//        pageState = .loading(request.progress)
        
//        pageState = .loading(progress)
//        DispatchQueue.global().async {
//
//            for i in 1...100 {
//                self.progress.completedUnitCount = Int64(i)
//                Thread.sleep(forTimeInterval: 1)
//
//                print("----- \(i)")
//
//                if i == 5 {
//                    self.progress.pause()
//                }
//
//                if i == 7 {
//                    self.progress.resume()
//                }
//
//                if i > 10 {
//                    self.pageState = .normal
//                    break
//                }
//            }
//        }
    }
    
    override func errorViewDidTap(tapGesture: UITapGestureRecognizer) {
        pageState = .normal
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let progress = object as? Progress {
            print(progress)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
