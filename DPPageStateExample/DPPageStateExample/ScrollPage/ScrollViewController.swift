//
//  ScrollViewController.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/10.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

class ScrollViewController: StateViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private lazy var normalTapGesture = UITapGestureRecognizer(target: self, action: #selector(normalViewDidTap(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageState = .initial(nil)
        
        scrollView.subviews.first?.addGestureRecognizer(normalTapGesture)
        
        scrollView.alwaysBounceVertical = true
    }
    
    override var stateContainerView: UIView {
        return scrollView
    }
    
    override func initialViewDidTap(_ tapGesture: UITapGestureRecognizer) {
        pageState = .normal
    }
    
    @objc
    func normalViewDidTap(_ tapGesture: UITapGestureRecognizer) {
        pageState = .initial(nil)
    }
}
