//
//  BaseViewController.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/4/4.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPPageState

enum MyError: Error {
    case test
    case normal
}

class MyView: UIView {
    
    lazy var label: UILabel = UILabel(frame: CGRect.zero)
    
    override func layoutSubviews() {
        
        if label.superview != self {
            addSubview(label)
        }
        
        label.textColor = UIColor(white: 0.8, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 66)
        label.frame = bounds
    }
}

class BaseViewController: DPPageStateViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}
