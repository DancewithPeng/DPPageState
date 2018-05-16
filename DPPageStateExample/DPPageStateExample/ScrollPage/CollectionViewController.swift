//
//  CollectionViewController.swift
//  DPPageStateExample
//
//  Created by DancewithPeng on 2018/5/17.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

class CollectionViewController: StateViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pageState = .loading(nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+10) {
            self.pageState = .empty(nil)
            self.collectionView.reloadData()
        }
        
        collectionView.alwaysBounceVertical = true
    }
    
    override var stateContainerView: UIView {
        return collectionView
    }
    
    override func emptyViewDidTap(_ tapGesture: UITapGestureRecognizer) {
        pageState = .normal
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if case .normal = pageState {
            return 100
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        
        let r = CGFloat(arc4random() % 256) / 255.0
        let g = CGFloat(arc4random() % 256) / 255.0
        let b = CGFloat(arc4random() % 256) / 255.0
        cell.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        return cell
    }
}
