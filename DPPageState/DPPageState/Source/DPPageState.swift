//
//  DPPageState.swift
//  DPPageState
//
//  Created by 张鹏 on 2018/3/30.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

/// 页面状态控制器
public protocol StateController {
    
    /// 页面状态
    var pageState: State { get set }
    
    /// 状态页容器
    var stateContainerView: UIView { get }
    
    
    // 以下四个方法用于获取状态对应的状态页，每个方法都有可能反复调用多次
    
    /// 获取初始状态页
    ///
    /// - Parameter userInfo: 附带的用户信息
    /// - Returns: 初始状态页
    func viewForInitial(with userInfo: Any?) -> DPPageState.InitialView
    
    /// 获取空状态页
    ///
    /// - Parameter userInfo: 附带的用户信息
    /// - Returns: 空状态页
    func viewForEmpty(with userInfo: Any?) -> DPPageState.EmptyView
    
    /// 获取错误状态页
    ///
    /// - Parameter error: 错误信息
    /// - Returns: 错误状态页
    func viewForError(_ error: Error) -> DPPageState.ErrorView
    
    /// 获取加载状态页
    ///
    /// - Parameter progress: 加载进度
    /// - Returns: 加载状态页
    func viewForLoading(with progress: Progress?) -> DPPageState.LoadingView
}


// MARK: - 为 `StateController` 协议添加 `defaultHandingChange(_:)` 方法
public extension StateController {
    
    /// 状态变化的默认处理
    ///
    /// - Parameter state: 新的状态
    func defaultHandingChange(_ newState: State) {

        // UI处理需要在主线程中执行
        DispatchQueue.main.async {
            
            var stateView: UIView? = nil
            
            // 根据状态获取对应的StateView
            switch newState {
            case .initial(let userInfo):
                stateView = self.viewForInitial(with: userInfo)
            case .empty(let userInfo):
                stateView = self.viewForEmpty(with: userInfo)
            case .error(let error):
                stateView = self.viewForError(error)
            case .loading(let progress):
                stateView = self.viewForLoading(with: progress)
            case .normal:
                stateView = nil
            }
            
            // 添加或移除状态页
            if let sView = stateView {
                
                if (sView.superview != self.stateContainerView) {
                    
                    // 移除原本的StateView
                    self.removeStateViews()
                    
                    // 添加新的StateView
                    self.stateContainerView.addSubview(sView)
                    
                    // 添加相关约束
                    sView.translatesAutoresizingMaskIntoConstraints = false
                    sView.leadingAnchor.constraint(equalTo: self.stateContainerView.leadingAnchor).isActive = true
                    sView.topAnchor.constraint(equalTo: self.stateContainerView.topAnchor).isActive = true
                    sView.trailingAnchor.constraint(equalTo: self.stateContainerView.trailingAnchor).isActive = true
                    sView.bottomAnchor.constraint(equalTo: self.stateContainerView.bottomAnchor).isActive = true
                    
                    if let scrollView = self.stateContainerView as? UIScrollView {
                        
                        var insetHeight = scrollView.contentInset.top + scrollView.contentInset.bottom
                        var insetWidth = scrollView.contentInset.left + scrollView.contentInset.right
                        
                        if #available(iOS 11, *) {
                            insetHeight += (scrollView.adjustedContentInset.top + scrollView.adjustedContentInset.bottom)
                            insetWidth += (scrollView.adjustedContentInset.left + scrollView.adjustedContentInset.right)
                        }
                        
                        sView.heightAnchor.constraint(equalTo: self.stateContainerView.heightAnchor, constant: -insetHeight).isActive = true
                        sView.widthAnchor.constraint(equalTo: self.stateContainerView.widthAnchor, constant: -insetWidth).isActive = true
                    }
                }
            } else {
                // 移除原本的StateView
                self.removeStateViews()
            }
        }
    }
    
    
    /// 移除容器上的StateView
    private func removeStateViews() {
        
        let subViews = stateContainerView.subviews;
        
        for subView in subViews {
            
            // 状态页
            if subView is StateView {
                
                // 加载状态页，需要先调用Cancel方法
                if let loadingView = subView as? LoadingView {
                    loadingView.loadingDidCancel()
                }
                
                subView.removeFromSuperview()
            }
        }
    }
}
