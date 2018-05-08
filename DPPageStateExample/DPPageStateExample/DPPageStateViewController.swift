//
//  DPPageStateViewController.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/7.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPPageState

class DPPageStateViewController: UIViewController, StateController {
    
    private lazy var errorViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(errorViewDidTap(tapGesture:)))
    
    var pageState: State = .normal {
        didSet {
            defaultHandingForStateChanged(newState: pageState)
        }
    }
    
    func viewForInitial(userInfo: Any?) -> InitialView {
        return TestInitialView(userInfo: userInfo)
    }

    func viewForEmpty(userInfo: Any?) -> EmptyView {
        return TestEmptyView(userInfo: userInfo)
    }

    func viewForError(_ error: Error) -> ErrorView {
        let errorView = TestErrorView(error: error)
        if errorView.gestureRecognizers?.contains(errorViewTapGesture) != true {
            errorView.addGestureRecognizer(errorViewTapGesture)
        }
        return errorView
    }

    func viewForLoading(progress: Progress?) -> LoadingView {
        return TestLoadingView(loadingProgress: progress)
    }
    
    var stateContainerView: UIView {
        return self.view
    }
    
    @objc
    open func errorViewDidTap(tapGesture: UITapGestureRecognizer) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
