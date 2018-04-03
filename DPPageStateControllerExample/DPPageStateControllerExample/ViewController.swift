//
//  ViewController.swift
//  DPPageStateControllerExample
//
//  Created by 张鹏 on 2018/3/30.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPPageStateController

class MyView: UIView {
    
    lazy var label: UILabel = UILabel(frame: CGRect.zero)
    
    override func layoutSubviews() {
        label.text = "MyView"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 66)
        label.frame = bounds
    }
}

class ViewController: UIViewController, DPPageStateController {
    
    typealias InitialView = MyView
    typealias EmptyView = MyView
    typealias ErrorView = MyView
    typealias LoadingView = MyView

    var pageState: DPPageState = .normal {
        didSet {
            stateDidChange(newState: pageState)
        }
    }
    
    lazy var initialView: MyView = MyView()
    lazy var emptyView: MyView = MyView()
    lazy var errorView: MyView = MyView()
    lazy var loadingView: MyView = MyView()
    
    var stateContainerView: UIView {
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyView.backgroundColor = UIColor.lightGray
        initialView.backgroundColor = UIColor.purple
        errorView.backgroundColor = UIColor.red
        loadingView.backgroundColor = UIColor.yellow
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if pageState == .normal {
            let i = arc4random() % 4 + 1
            switch i {
            case 1:
                pageState = .initial
            case 2:
                pageState = .empty
            case 3:
                pageState = .error
            case 4:
                pageState = .loading
            default:
                pageState = .normal
            }
        } else {
            pageState = .normal
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

