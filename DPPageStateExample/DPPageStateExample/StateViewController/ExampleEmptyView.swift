//
//  ExampleEmptyView.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/9.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import DPPageState

/// 空状态页
class ExampleEmptyView: DPPageState.EmptyView {
    
    lazy var iconImageView = UIImageView(frame: CGRect.zero)
    lazy var messageLabel = UILabel(frame: CGRect.zero)
    
    override init(userInfo: Any?) {
        super.init(userInfo: userInfo)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    func setupSubviews() {
        addSubview(iconImageView)
        addSubview(messageLabel)
        
        backgroundColor = .white
        
        iconImageView.image = #imageLiteral(resourceName: "icon_empty")
        messageLabel.text = "暂时没有数据哦(>﹏<)"
        messageLabel.textColor = .gray
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
        iconImageView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -10).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    deinit {
        print("🐯🐯🐯")
    }
}
