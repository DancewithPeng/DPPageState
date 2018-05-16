//
//  LoadingView.swift
//  DPPageState
//
//  Created by 张鹏 on 2018/5/7.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit


// Encode Keys
private let kLoadingProgressEncodeKey = "kLoadingProgressEncodeKey"


/// 加载中的状态页
open class LoadingView: StateView {
    
    /// 加载进度
    public var loadingProgress: Progress? {
        willSet { loadingProgressWillChange(loadingProgress) }
        didSet { loadingProgressDidChange(loadingProgress) }
    }
    
    
    // MARK: - Initialization
    
    public init(loadingProgress: Progress? = nil) {
        self.loadingProgress = loadingProgress
        super.init(frame: CGRect.zero)
        
        loadingProgressDidChange(loadingProgress)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        loadingProgress = aDecoder.decodeObject(forKey: kLoadingProgressEncodeKey) as? Progress
        super.init(coder: aDecoder)
        
        loadingProgressDidChange(loadingProgress)
    }
    
    open override func encode(with aCoder: NSCoder) {
        aCoder.encode(loadingProgress, forKey: kLoadingProgressEncodeKey)
        super.encode(with: aCoder)
    }
    
    
    // MARK: - Override Points
    
    /// 加载开始
    open func loadingDidStart() {}

    /// 更新加载进度
    ///
    /// - Parameters:
    ///   - fractionCompleted:  进度完成的百分比
    ///   - totalUnitCount:     总进度
    ///   - completedUnitCount: 完成的进度
    open func loadingDidUpdateProgress(fractionCompleted: Double, totalUnitCount: Int64, completedUnitCount: Int64) {}

    /// 加载暂停
    open func loadingDidPause() {}

    /// 加载继续
    open func loadingDidResume() {}

    /// 加载取消
    open func loadingDidCancel() {}

    /// 加载完成
    open func loadingDidFinish() {}
    
    
    // MARK: - Helper Methods
    
    
    /// 进度对象将要改变
    private func loadingProgressWillChange(_ oldProgress: Progress?) {
        if let progress = oldProgress {
            progress.removeObserver(self, forKeyPath: #keyPath(Progress.completedUnitCount))
        }
    }
    
    /// 进度对象改变
    private func loadingProgressDidChange(_ newProgress: Progress?) {
        
        // 处理重新开始逻辑
        DispatchQueue.main.async {
            self.loadingDidStart()
        }
        
        if let progress = newProgress {
            
            // 监听进度变化
            progress.addObserver(self, forKeyPath: #keyPath(Progress.completedUnitCount), options: [.initial, .new], context: nil)
            
            
            // 处理相关事件
            
            // 取消
            progress.cancellationHandler = { [weak self] in
                DispatchQueue.main.async {
                    self?.loadingDidCancel()
                }                
            }
            
            // 暂停
            progress.pausingHandler = { [weak self] in
                DispatchQueue.main.async {
                    self?.loadingDidPause()
                }
            }
            
            // 继续
            progress.resumingHandler = { [weak self] in
                DispatchQueue.main.async {
                    self?.loadingDidResume()
                }
            }
        }
    }
    
    
    // MARK: - KVO
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // Progress.completedUnitCount
        if let progress = object as? Progress, keyPath == #keyPath(Progress.completedUnitCount) {
            
            // 更新进度
            DispatchQueue.main.async {
                self.loadingDidUpdateProgress(fractionCompleted: progress.fractionCompleted, totalUnitCount: progress.totalUnitCount, completedUnitCount: progress.completedUnitCount)
            }
            
            // 进度完成
            if progress.totalUnitCount > 0, progress.completedUnitCount >= progress.totalUnitCount {
                DispatchQueue.main.async {
                    self.loadingDidFinish()
                }
            }
        }
    }
    
    deinit {
        loadingProgress?.removeObserver(self, forKeyPath: #keyPath(Progress.completedUnitCount))
    }
}
