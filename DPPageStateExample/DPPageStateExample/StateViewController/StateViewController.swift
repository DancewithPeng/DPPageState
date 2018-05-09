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
        return ExampleEmptyView(userInfo: userInfo)
    }
    
    // 错误状态页
    func viewForError(_ error: Error) -> ErrorView {
        return ExampleErrorView(error: error)
    }
    
    // 加载状态页
    func viewForLoading(with progress: Progress?) -> LoadingView {
        return ExampleLoadingView(loadingProgress: progress)
    }
}
