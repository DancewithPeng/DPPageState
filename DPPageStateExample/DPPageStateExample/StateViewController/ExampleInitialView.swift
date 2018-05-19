//
//  ExampleInitialView.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/9.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import DPPageState
import DPLog

/// 初始状态页
class ExampleInitialView: DPPageState.InitialView {
    
    lazy var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    lazy var messageLabel = UILabel(frame: CGRect.zero)
    lazy var centerLayoutGuide = UILayoutGuide()
    
    override init(userInfo: Any?) {
        super.init(userInfo: userInfo)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    /// 配置子View
    func setupSubviews() {
        
        addSubview(activityIndicator)
        addSubview(messageLabel)
        addLayoutGuide(centerLayoutGuide)
        
        messageLabel.text = "正在初始化数据..."
        messageLabel.textColor = .gray
        activityIndicator.startAnimating()
        backgroundColor = .white
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        centerLayoutGuide.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        centerLayoutGuide.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        activityIndicator.leadingAnchor.constraint(equalTo: centerLayoutGuide.leadingAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerLayoutGuide.centerYAnchor).isActive = true
        
        messageLabel.leadingAnchor.constraint(equalTo: activityIndicator.trailingAnchor, constant: 6).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: centerLayoutGuide.trailingAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: centerLayoutGuide.topAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: centerLayoutGuide.bottomAnchor).isActive = true
    }
    
    deinit {
        LogInfo("🐶🐶🐶")
    }
}
