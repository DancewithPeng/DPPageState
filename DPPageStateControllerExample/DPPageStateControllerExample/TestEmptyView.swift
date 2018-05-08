//
//  TestEmptyView.swift
//  DPPageStateControllerExample
//
//  Created by 张鹏 on 2018/5/8.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import DPPageStateController

class TestEmptyView: DPPageStateEmptyView {
    
    lazy var messageLabel = UILabel(frame: CGRect.zero)
    
    override init(userInfo: Any? = nil) {
        super.init(userInfo: userInfo)
        
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupSubviews()
    }
    
    override func awakeFromNib() {
        setupSubviews()
    }
    
    func setupSubviews() {
        
        backgroundColor = .yellow
        
        addSubview(messageLabel)
        if let info = userInfo {
            messageLabel.text = "\(info)"
        }
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 60).isActive = true
        messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -60).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
