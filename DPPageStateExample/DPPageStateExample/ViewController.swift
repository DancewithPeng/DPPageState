//
//  ViewController.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/3/30.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPPageState

class ViewController: BaseViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if DPPageState.normal ~= pageState {
//            let i = arc4random() % 4 + 1
//            switch i {
//            case 1:
//                pageState = .initial
//            case 2:
//                pageState = .empty
//            case 3:
//                pageState = .error
//            case 4:
//                pageState = .loading
//            default:
//                pageState = .normal
//            }
//        } else {
//            pageState = .normal
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

