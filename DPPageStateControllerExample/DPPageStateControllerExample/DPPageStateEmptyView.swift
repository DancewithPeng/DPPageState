//
//  DPPageStateEmptyView.swift
//  DPPageStateControllerExample
//
//  Created by 张鹏 on 2018/5/7.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit


/// 空页面
class DPPageStateEmptyView: UIView {
    
    lazy var label: UILabel = UILabel(frame: CGRect.zero)
    
    override func layoutSubviews() {
        
        if label.superview != self {
            addSubview(label)
            label.text = "DPPageStateEmptyView"
        }
        
        label.textColor = UIColor(white: 0.8, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 66)
        label.frame = bounds
    }
}
