//
//  DPPageStateErrorView.swift
//  DPPageStateController
//
//  Created by 张鹏 on 2018/5/8.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit


// Encode Keys
private let kErrorEncodeKey = "kErrorEncodeKey"


/// 错误状态页
open class DPPageStateErrorView: DPPageStateView {
    
    public var error: Error { didSet { errorDidChange(error) } }
    
    public init(error: Error) {
        self.error = error
        super.init(frame: CGRect.zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        guard let error = aDecoder.decodeObject(forKey: kErrorEncodeKey) as? Error else {
            return nil
        }
        
        self.error = error
        super.init(coder: aDecoder)
    }
    
    open override func encode(with aCoder: NSCoder) {
        aCoder.encode(error, forKey: kErrorEncodeKey)
        super.encode(with: aCoder)
    }
    
    open func errorDidChange(_ error: Error) {}
}
