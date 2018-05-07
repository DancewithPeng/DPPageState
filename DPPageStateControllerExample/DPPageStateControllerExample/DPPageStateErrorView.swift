//
//  DPPageStateErrorView.swift
//  DPPageStateControllerExample
//
//  Created by 张鹏 on 2018/5/7.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPPageStateController

enum NormalError: Error {
    case aaa
}

class DPPageStateDefaultErrorView: UIView, DPPageStateErrorView {
    
    lazy var label: UILabel = UILabel(frame: CGRect.zero)
    var error: Error = NormalError.aaa
    
    override func layoutSubviews() {
        
        if label.superview != self {
            addSubview(label)
            label.text = error.localizedDescription
        }
        
        label.textColor = UIColor(white: 0.8, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 66)
        label.frame = bounds
    }
}
