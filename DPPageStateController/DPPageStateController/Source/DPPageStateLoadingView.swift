//
//  DPPageStateLoadingView.swift
//  DPPageStateController
//
//  Created by 张鹏 on 2018/5/7.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

/// 加载中的状态页
open class DPPageStateLoadingView: UIView {
    
    /// 加载进度
    var loadingProgress: Progress? { didSet { loadingProgressDidChange(newProgress: loadingProgress) } }
    
    /// 进度是否重新开始
    private var isNewStart = false
    
    /// 加载开始
    func loadingDidStart() {}

    /// 更新加载进度
    ///
    /// - Parameters:
    ///   - fractionCompleted:  进度完成的百分比
    ///   - totalUnitCount:     总进度
    ///   - completedUnitCount: 完成的进度
    func loadingDidUpdateProgress(fractionCompleted: Double, totalUnitCount: Int64, completedUnitCount: Int64) {}

    /// 加载暂停
    func loadingDidPause() {}

    /// 加载继续
    func loadingDidResume() {}

    /// 加载取消
    func loadingDidCancel() {}

    /// 加载完成
    func loadingDidFinish() {}
    
    
    /// 进度对象改变
    private func loadingProgressDidChange(newProgress: Progress?) {
        
        if let progress = newProgress {
            
            // 处理重新开始逻辑
            isNewStart = true
            
            // 监听进度变化
            progress.addObserver(self, forKeyPath: "completedUnitCount", options: [.initial, .new], context: nil)
            
            // 处理相关事件
            
            // 取消
            progress.cancellationHandler = { [unowned self] in
                self.loadingDidCancel()
                self.isNewStart = true
            }
            
            // 暂停
            progress.pausingHandler = { [unowned self] in
                self.loadingDidPause()
            }
            
            // 继续
            progress.resumingHandler = { [unowned self] in
                self.loadingDidResume()
            }
        }
    }
    
    // KVO
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // Progress.completedUnitCount
        if let progress = object as? Progress, keyPath == "completedUnitCount" {
            
            // 判断是否重新开始
            if isNewStart {
                loadingDidStart()
                isNewStart = false
            }
            
            // 更新进度
            loadingDidUpdateProgress(fractionCompleted: progress.fractionCompleted, totalUnitCount: progress.totalUnitCount, completedUnitCount: progress.completedUnitCount)
            
            // 进度完成
            if progress.completedUnitCount >= progress.totalUnitCount {
                loadingDidFinish()
                isNewStart = true
            }
        }
    }
}
