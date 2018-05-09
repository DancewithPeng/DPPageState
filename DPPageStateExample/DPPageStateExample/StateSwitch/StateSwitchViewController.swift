//
//  StateSwitchViewController.swift
//  DPPageStateExample
//
//  Created by 张鹏 on 2018/5/9.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import Alamofire

enum ExampleError: Error {
    case msg(String)
}

class StateSwitchViewController: StateViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var animatedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func animatedDidSwitch(_ sender: UISwitch) {
        sender.isOn = !sender.isOn
        messageLabel.isEnabled = sender.isOn
    }
    
    @IBAction func segmentedControlSeletedDidChange(_ sender: UISegmentedControl) {
        
        if animatedSwitch.isOn {
            UIView.transition(with: view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                self.switchPageState(for: sender.selectedSegmentIndex)
            }, completion: nil)
        } else {
            switchPageState(for: sender.selectedSegmentIndex)
        }
    }
    
    func switchPageState(for selectedIndex: Int) {
        
        switch selectedIndex {
        case 0:
            pageState = .normal
        case 1:
            pageState = .initial("Initial 🐯🐯🐯")
        case 2:
            pageState = .empty("Empty 🦁🦁🦁")
        case 3:
            pageState = .error(ExampleError.msg("出错啦~~~"))
        case 4:
            
            let request =
            Alamofire.request("https://codeload.github.com/dzenbot/DZNEmptyDataSet/zip/master").responseData { (response) in
                if let value = response.value {
                    print(value)
                } else if let error = response.error {
                    print(error)
                }
            }
            
            pageState = .loading(request.progress)
        default: break
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
