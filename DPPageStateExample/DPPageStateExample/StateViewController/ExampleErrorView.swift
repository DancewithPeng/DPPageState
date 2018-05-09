//
//  ExampleErrorView.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/9.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import DPPageState

/// 错误状态页
class ExampleErrorView: DPPageState.ErrorView {
    
    lazy var iconImageView = UIImageView(frame: CGRect.zero)
    lazy var messageLabel = UILabel(frame: CGRect.zero)
    
    override init(error: Error) {
        super.init(error: error)
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
        
        iconImageView.image = #imageLiteral(resourceName: "icon_error")
        
        if case let ExampleError.msg(msg) = error {
            messageLabel.text = msg
        } else {
            messageLabel.text = error.localizedDescription
        }
        
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 60).isActive = true
        messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -60).isActive = true
        
        iconImageView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -10).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    deinit {
        print("🦋🦋🦋")
    }
}
