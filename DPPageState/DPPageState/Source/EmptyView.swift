//
//  EmptyView.swift
//  DPPageState
//
//  Created by 张鹏 on 2018/5/8.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit


// Encode Keys
private let kUserInfoEncodeKey = "kUserInfoEncodeKey"


/// 空白状态页
open class EmptyView: StateView {
    
    /// 用户信息，预留属性，子类可以直接使用此属性传递相关信息
    public var userInfo: Any? { didSet { userInfoDidChange(userInfo) } }
    
    public init(userInfo: Any? = nil) {
        self.userInfo = userInfo
        super.init(frame: CGRect.zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.userInfo = aDecoder.decodeObject(forKey: kUserInfoEncodeKey)
        super.init(coder: aDecoder)
    }
    
    open override func encode(with aCoder: NSCoder) {
        aCoder.encode(userInfo, forKey: kUserInfoEncodeKey)
        super.encode(with: aCoder)
    }
    
    /// 用户信息改变
    ///
    /// - Parameter userInfo: 新的用户信息
    open func userInfoDidChange(_ userInfo: Any?) {}
}
