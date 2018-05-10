//
//  ExampleLoadingView.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/9.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import DPPageState
import DPLog

/// 加载状态页
class ExampleLoadingView: DPPageState.LoadingView {
    
    lazy var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    lazy var progressLabel = UILabel(frame: CGRect.zero)
    lazy var resultLabel = UILabel(frame: CGRect.zero)
    
    var activityIndicatorBottomConstraint: NSLayoutConstraint?
    var activityIndicatorCenterYConstraint: NSLayoutConstraint?
    
    override init(loadingProgress: Progress?) {
        super.init(loadingProgress: loadingProgress)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    /// 配置子View
    func setupSubviews() {
        
        addSubview(activityIndicator)
        addSubview(progressLabel)
        addSubview(resultLabel)
        
        progressLabel.textColor = .gray
        activityIndicator.color = .gray
        backgroundColor = .white
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        progressLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        progressLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 60).isActive = true
        progressLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -60).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        activityIndicatorBottomConstraint = activityIndicator.bottomAnchor.constraint(equalTo: progressLabel.topAnchor, constant: -10)
        activityIndicatorCenterYConstraint = activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        if loadingProgress != nil {
            activityIndicatorBottomConstraint?.isActive = true
        } else {
            activityIndicatorCenterYConstraint?.isActive = true
        }
        
        resultLabel.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor).isActive = true
        resultLabel.isHidden = true
    }
    
    override func loadingDidStart() {
        if loadingProgress != nil {
            activityIndicatorCenterYConstraint?.isActive = false
            activityIndicatorBottomConstraint?.isActive = true
        } else {
            activityIndicatorBottomConstraint?.isActive = false
            activityIndicatorCenterYConstraint?.isActive = true
        }
        
        activityIndicator.startAnimating()
    }
    
    override func loadingDidCancel() {
        activityIndicator.stopAnimating()
    }
    
    override func loadingDidFinish() {
        activityIndicator.stopAnimating()
        resultLabel.text = "加载完成✅"
        resultLabel.isHidden = false
    }
    
    override func loadingDidUpdateProgress(fractionCompleted: Double, totalUnitCount: Int64, completedUnitCount: Int64) {
        progressLabel.text = "\(Int(fractionCompleted*100))%"
    }
    
    deinit {
        LogInfo("🐮🐮🐮")
    }
}
