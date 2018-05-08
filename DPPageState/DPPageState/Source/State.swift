//
//  State.swift
//  DPPageState
//
//  Created by DancewithPeng on 2018/5/8.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// 页面状态
///
/// - normal:  正常状态，不会显示状态页
/// - initial: 初始状态
/// - empty:   空数据状态
/// - error:   错误状态
/// - loading: 加载状态
public enum State {    
    case normal
    case initial(Any?)
    case empty(Any?)
    case error(Error)
    case loading(Progress?)
}
