//
//  DPPageStateController.swift
//  DPPageStateController
//
//  Created by 张鹏 on 2018/3/30.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation


/// 页面状态
///
/// - normal:  正常状态
/// - initial: 初始状态
/// - empty:   空数据状态
/// - error:   错误状态
/// - loading: 加载状态
public enum DPPageState {
    case normal
    case initial
    case empty(String?)
    case error(Error)
    case loading(Progress?)
}


/// 页面状态控制器
public protocol DPPageStateController {
    
    /// 初始状态页类型
    associatedtype InitialView: UIView
    
    /// 空状态页类型
    associatedtype EmptyView: UIView
    
    /// 错误状态页类型
    associatedtype ErrorView: UIView, DPPageStateErrorView
    
    /// 加载页类型
//    associatedtype LoadingView: DPPageStateLoadingView
    
    
    /// 页面状态
    var pageState: DPPageState { get set }        
    
    func viewForInitial() -> InitialView
    func viewForEmpty() -> EmptyView
    func viewForError(_ error: Error) -> ErrorView
    func viewForLoading(progress: Progress?) -> DPPageStateLoadingView
    
    /// 状态页容器
    var stateContainerView: UIView { get }
}


// MARK: - 为 `DPPageStateController` 协议添加 `stateDidChange(newState:)` 方法
public extension DPPageStateController {
    
    /// 状态变化的默认处理
    ///
    /// - Parameter state: 新的状态
    func defaultHandingForStateChanged(newState state: DPPageState) {

        var stateView: UIView? = nil

        switch state {
        case .initial:
            stateView = viewForInitial()
            stateView?.tag = DPPageStateViewTag.initial.rawValue
        case .empty(let message):
            stateView = viewForEmpty()
            stateView?.tag = DPPageStateViewTag.empty.rawValue
        case .error(let error):
            stateView = viewForError(error)
            stateView?.tag = DPPageStateViewTag.error.rawValue
        case .loading(let progress):
            let loadingView = viewForLoading(progress: progress)
            loadingView.loadingProgress = progress
            stateView = loadingView
            stateView?.tag = DPPageStateViewTag.loading.rawValue
        case .normal:
            stateView = nil
        }

        if let sView = stateView {
            
            if (sView.superview != stateContainerView) {
                
                // UI操作需要在主线程进行
                DispatchQueue.main.async {
                    
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
            }
        } else {
            
            DispatchQueue.main.async {
                // 移除原本的StateView
                self.removeStateViewFromContainerView()
            }
        }
    }
    
    
    /// 移除容器上的StateView
    private func removeStateViewFromContainerView() {
        
        let subViews = stateContainerView.subviews;
        
        for subView in subViews {
            
            switch subView.tag {
                
            case DPPageStateViewTag.initial.rawValue: fallthrough
            case DPPageStateViewTag.empty.rawValue: fallthrough
            case DPPageStateViewTag.loading.rawValue:
                if let loadingView = subView as? DPPageStateLoadingView {
                    loadingView.loadingDidFinish()
                }
                fallthrough
            case DPPageStateViewTag.error.rawValue:
                subView.removeFromSuperview()
            default: break
            }
        }
    }
}


// MARK: - DPPageStateErrorView


public protocol DPPageStateErrorView {
    var error: Error { get set }
}


// MARK: - Tag Defines


/// 状态View的Tag
private enum DPPageStateViewTag: Int {
    case initial    = 666666
    case empty      = 666665;
    case error      = 666664;
    case loading    = 666663;
}

