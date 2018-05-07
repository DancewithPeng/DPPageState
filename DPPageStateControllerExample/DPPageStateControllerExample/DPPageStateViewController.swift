//
//  DPPageStateViewController.swift
//  DPPageStateControllerExample
//
//  Created by 张鹏 on 2018/5/7.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPPageStateController

class DPPageStateViewController: UIViewController, DPPageStateController {
    
    var pageState: DPPageState = .normal {
        didSet {
            defaultHandingForStateChanged(newState: pageState)
        }
    }
    
    typealias InitialView = DPPageStateInitialView
    typealias EmptyView = DPPageStateEmptyView
    typealias ErrorView = DPPageStateDefaultErrorView
//    typealias LoadingView = DPPageStateDefaultLoadingView
    
    func initialView() -> DPPageStateInitialView {
        return DPPageStateInitialView(frame: CGRect.zero)
    }
    
    func emptyView(message: String?) -> DPPageStateEmptyView {
        return DPPageStateEmptyView(frame: CGRect.zero)
    }
    
    func errorView(error: Error) -> DPPageStateDefaultErrorView {
        return DPPageStateDefaultErrorView(frame: CGRect.zero)
    }
    
//    func loadingView(progress: Progress?) -> DPPageStateDefaultLoadingView {                
//        return DPPageStateDefaultLoadingView(frame: CGRect.zero)
//    }
    
    var stateContainerView: UIView {
        return self.view
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
