//
//  DPPageState.swift
//  DPPageState
//
//  Created by 张鹏 on 2018/3/30.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation


/// 页面状态控制器
public protocol StateController {
    
    /// 页面状态
    var pageState: State { get set }
    
    // 以下四个方法用于获取状态对应的状态页，每个方法都有可能反复调用多次
    func viewForInitial(userInfo: Any?) -> InitialView
    func viewForEmpty(userInfo: Any?) -> EmptyView
    func viewForError(_ error: Error) -> ErrorView
    func viewForLoading(progress: Progress?) -> LoadingView
    
    /// 状态页容器
    var stateContainerView: UIView { get }
}


// MARK: - 为 `StateController` 协议添加 `defaultHandingForStateChanged(newState:)` 方法
public extension StateController {
    
    /// 状态变化的默认处理
    ///
    /// - Parameter state: 新的状态
    func defaultHandingForStateChanged(newState state: State) {

        // UI处理需要在主线程中执行
        DispatchQueue.main.async {
            
            var stateView: UIView? = nil
            
            // 根据状态获取对应的StateView
            switch state {
            case .initial(let userInfo):
                stateView = self.viewForInitial(userInfo: userInfo)
            case .empty(let userInfo):
                stateView = self.viewForEmpty(userInfo: userInfo)
            case .error(let error):
                stateView = self.viewForError(error)
            case .loading(let progress):
                stateView = self.viewForLoading(progress: progress)
            case .normal:
                stateView = nil
            }
            
            // 添加或移除状态页
            if let sView = stateView {
                
                if (sView.superview != self.stateContainerView) {
                    
                    // 移除原本的StateView
                    self.removeStateViewFromContainerView()
                    
                    // 添加新的StateView
                    self.stateContainerView.addSubview(sView)
                    
                    // 添加相关约束
                    sView.translatesAutoresizingMaskIntoConstraints = false
                    sView.leadingAnchor.constraint(equalTo: self.stateContainerView.leadingAnchor).isActive = true
                    sView.topAnchor.constraint(equalTo: self.stateContainerView.topAnchor).isActive = true
                    sView.trailingAnchor.constraint(equalTo: self.stateContainerView.trailingAnchor).isActive = true
                    sView.bottomAnchor.constraint(equalTo: self.stateContainerView.bottomAnchor).isActive = true
                    
                    if self.stateContainerView is UIScrollView {
                        sView.heightAnchor.constraint(equalTo: self.stateContainerView.heightAnchor).isActive = true
                        sView.widthAnchor.constraint(equalTo: self.stateContainerView.widthAnchor).isActive = true
                    }
                }
            } else {
                // 移除原本的StateView
                self.removeStateViewFromContainerView()
            }
        }
    }
    
    
    /// 移除容器上的StateView
    private func removeStateViewFromContainerView() {
        
        let subViews = stateContainerView.subviews;
        
        for subView in subViews {
            
            // 状态页
            if subView is StateView {
                
                // 加载状态页
                if let loadingView = subView as? LoadingView {
                    loadingView.loadingDidCancel()
                }
                
                subView.removeFromSuperview()
            }
        }
    }
}
