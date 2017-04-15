//
//  ViewController.swift
//  NYAlertViewManger
//
//  Created by 宁哥 on 2017/4/15.
//  Copyright © 2017年 qyning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func aaaa() {
        let action1 = RTAction(Title: "done", Handle: nil)
        let action2 = RTAction(Title: "cancel", Handle: nil)
        let alertV = NYAlertViewManger.shared.alert(title: "aaaaa", message: "", Alertstyle: .actionSheet, actions: [action1,action2])
        NYAlertViewManger.shared.showAlertVC(alertVC: alertV)

    }
    func bbbb() {
        let action1 = RTAction(Title: "done", Handle: nil)
        let alertV = NYAlertViewManger.shared.alert(title: "bbbb", message: "", Alertstyle: .alert, actions: [action1])
        NYAlertViewManger.shared.showAlertVC(alertVC: alertV)
    }
    func cccc() {
        let action1 = RTAction(Title: "done", Handle: nil)
        let alertV = NYAlertViewManger.shared.alert(title: "ccccc", message: "", Alertstyle: .alert, actions: [action1])
        NYAlertViewManger.shared.showAlertVC(alertVC: alertV)
    }

    @IBAction func stopNextAlert(_ sender: Any) {
        aaaa()
        NYAlertViewManger.shared.willShowNextAlertMode = false
        bbbb()
        cccc()
    }
    
    @IBAction func nextAlert(_ sender: Any) {
        NYAlertViewManger.shared.showNext()
    }
    @IBAction func autoAlert(_ sender: Any) {
        NYAlertViewManger.shared.willShowNextAlertMode = true
        aaaa()
        bbbb()
        cccc()
    }

}

