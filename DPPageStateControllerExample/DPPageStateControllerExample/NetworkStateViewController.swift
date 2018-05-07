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
        
        unowned let obj = TestObj()
        progress.cancellationHandler = {
            obj.hahah()
        }
        
        unowned let obj2 = TestObj()
        progress.pausingHandler = {
            obj2.hahah()
        }
        
        unowned let obj3 = TestObj()
        progress.resumingHandler = {
            obj3.hahah()
        }
        
        DispatchQueue.global().async {
            
            for i in 1...100 {
                self.progress.completedUnitCount = Int64(i)
                Thread.sleep(forTimeInterval: 1)
                
                print("----- \(i)")
                
                if i == 5 {
                    self.progress.pause()
                }
                
                if i == 7 {
                    self.progress.resume()
                }
                
                if i > 10 {
                    self.progress.cancel()
                    break
                }
            }
        }
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
