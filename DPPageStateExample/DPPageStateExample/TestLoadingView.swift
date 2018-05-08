//
//  TestLoadingView.swift
//  DPPageStateExample
//
//  Created by DancewithPeng on 2018/5/7.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import DPPageState

class TestLoadingView: LoadingView {
        
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override init(loadingProgress: Progress?) {
        super.init(loadingProgress: loadingProgress)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        
        backgroundColor = .purple
        addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func loadingDidStart() {
        activityIndicator.startAnimating()
    }
    
    override func loadingDidCancel() {
        activityIndicator.stopAnimating()
        print("哈哈哈哈")
    }
    
    override func loadingDidFinish() {
        activityIndicator.stopAnimating()
        print("哦哦哦哦")
    }
}
