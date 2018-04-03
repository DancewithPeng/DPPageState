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
    case empty
    case error
    case loading
}


/// 页面状态控制器
public protocol DPPageStateController {
    
    /// 初始状态页类型
    associatedtype InitialView: UIView
    
    /// 空状态页类型
    associatedtype EmptyView: UIView
    
    /// 错误状态页类型
    associatedtype ErrorView: UIView
    
    /// 加载页类型
    associatedtype LoadingView: UIView
    
    
    /// 页面状态
    var pageState: DPPageState { get set }        
    
    /// 初始状态页
    var initialView: InitialView { get }
    
    /// 空状态页
    var emptyView: EmptyView { get }
    
    /// 错误状态页
    var errorView: ErrorView { get }
    
    /// 加载页
    var loadingView: LoadingView { get }
    
    
    /// 状态页容器
    var stateContainerView: UIView { get }
}


// MARK: - 为 `DPPageStateController` 协议添加 `stateDidChange(newState:)` 方法
public extension DPPageStateController{
    
    func stateDidChange(newState state: DPPageState) {
        
        initialView.removeFromSuperview()
        emptyView.removeFromSuperview()
        errorView.removeFromSuperview()
        loadingView.removeFromSuperview()
        
        var stateView: UIView? = nil
        
        switch state {
        case .initial:
            stateView = initialView
        case .empty:
            stateView = emptyView
        case .error:
            stateView = errorView
        case .loading:
            stateView = loadingView
        default:
            stateView = nil
        }
        
        if let sView = stateView {
            stateContainerView.addSubview(sView)
            
            sView.translatesAutoresizingMaskIntoConstraints = false
            sView.leadingAnchor.constraint(equalTo: stateContainerView.leadingAnchor).isActive = true
            sView.topAnchor.constraint(equalTo: stateContainerView.topAnchor).isActive = true
            sView.trailingAnchor.constraint(equalTo: stateContainerView.trailingAnchor).isActive = true
            sView.bottomAnchor.constraint(equalTo: stateContainerView.bottomAnchor).isActive = true
        }
    }
}

