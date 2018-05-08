//
//  TestErrorView.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/8.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import DPPageState

class TestErrorView: ErrorView {
    
    lazy var messageLabel = UILabel(frame: CGRect.zero)
    
    override init(error: Error) {
        super.init(error: error)
        
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
        
        backgroundColor = .red
        
        addSubview(messageLabel)
        messageLabel.text = error.localizedDescription
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 60)
        messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -60)        
    }
    
    override func errorDidChange(_ error: Error) {
        messageLabel.text = error.localizedDescription
    }
}
