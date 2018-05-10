//
//  StateViewController.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/9.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPPageState

/// 带状态控制的ViewController，实现 `DPPageState.StateController` 中属性和方法
class StateViewController: UIViewController, DPPageState.StateController {
    
    /// 空白页点击手势
    private lazy var emptyViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(emptyViewDidTap(_:)))
    
    /// 错误页点击手势
    private lazy var errorViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(errorViewDidTap(_:)))
    
    
    // 页面状态
    var pageState: State = .normal { didSet { defaultHandingChange(pageState) } }
    
    // 状态页容器
    var stateContainerView: UIView { get { return self.view } }
    
    // 初始状态页
    func viewForInitial(with userInfo: Any?) -> InitialView {
        return ExampleInitialView(userInfo: userInfo)
    }
    
    // 空状态页
    func viewForEmpty(with userInfo: Any?) -> EmptyView {
        
        let emptyView = ExampleEmptyView(userInfo: userInfo)
        if emptyViewTapGesture.view != emptyView {
            emptyView.addGestureRecognizer(emptyViewTapGesture)
        }
        
        return emptyView
    }
    
    // 错误状态页
    func viewForError(_ error: Error) -> ErrorView {
        let errorView = ExampleErrorView(error: error)
        if errorViewTapGesture.view != errorView {
            errorView.addGestureRecognizer(errorViewTapGesture)
        }
        return errorView
    }
    
    // 加载状态页
    func viewForLoading(with progress: Progress?) -> LoadingView {
        return ExampleLoadingView(loadingProgress: progress)
    }
    
    
    // MARK: - Override Points
    
    @objc
    open func emptyViewDidTap(_ tapGesture: UITapGestureRecognizer) {}
    
    @objc
    open func errorViewDidTap(_ tapGesture: UITapGestureRecognizer) {}
}
