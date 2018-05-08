//
//  CollectionViewController.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/4/4.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

class CollectionViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override var stateContainerView: UIView {
        return collectionView
    }
    
    lazy var isEmpty = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        collectionView.alwaysBounceVertical = true
        
//        pageState = .empty
        isEmpty = true
        
        let timer = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        timer.schedule(wallDeadline: .now(), repeating: 1)
        timer.setEventHandler {
            
//            if self.pageState == .normal {
//
//                self.isEmpty = true
//
//                let i = arc4random() % 4 + 1
//                switch i {
//                case 1:
//                    self.pageState = .initial
//                case 2:
//                    self.pageState = .empty
//                case 3:
//                    self.pageState = .error
//                case 4:
//                    self.pageState = .loading
//                default:
//                    self.pageState = .normal
//                    self.isEmpty = false
//                }
//            } else {
//                self.pageState = .normal
//                self.isEmpty = false
//            }
//
//            print(self.pageState)
//
//            self.collectionView.reloadData()
//
            if false {
                timer.cancel()
            }
        }

        timer.resume()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEmpty {
            return 0
        }
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor(red: CGFloat(Double(arc4random()%256)/255.0), green: CGFloat(Double(arc4random()%256)/255.0), blue: CGFloat(Double(arc4random()%256)/255.0), alpha: CGFloat(Double(arc4random()%256)/255.0))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.size.width, height: 66)
    }
}
