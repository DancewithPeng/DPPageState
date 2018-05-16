//
//  TableViewController.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/10.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

class TableViewController: StateViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageState = .loading(nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.dataSource.removeAll()
            self.tableView.reloadData()
            self.pageState = .empty(nil)
        }
    }
    
    override func emptyViewDidTap(_ tapGesture: UITapGestureRecognizer) {
        
        for i in 0..<100 {
            dataSource.append("\(i)")
        }
        
        tableView.reloadData()
        pageState = .normal
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kCell", for: indexPath)
        return cell
    }
    
    override var stateContainerView: UIView {
        return tableView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
