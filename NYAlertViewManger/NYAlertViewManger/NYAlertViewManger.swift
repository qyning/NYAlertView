//
//  NYAlertViewManger.swift
//  NYAlertViewManger
//
//  Created by 宁哥 on 2017/4/15.
//  Copyright © 2017年 qyning. All rights reserved.
//

import UIKit

final class NYAlertViewManger: NSObject {
    
    public var willShowNextAlertMode = true
    
    private var alertQueue:OperationQueue!
    private var semaphore:DispatchSemaphore!

    static let shared = NYAlertViewManger()
    private override init() {
        super.init()
        alertQueue = OperationQueue()
        alertQueue.maxConcurrentOperationCount = 1
        semaphore  = DispatchSemaphore(value: 0)
    }

    public func alert(title:String,message:String,Alertstyle:UIAlertControllerStyle,actions:[RTAction])->RTAlertView{
        let alerV = RTAlertView()
        alerV.alert(title: title, message: message, Alertstyle: Alertstyle, actions: actions)
        return alerV
    }
    
    public func showAlertVC(alertVC:RTAlertView) {
        let operation = BlockOperation {
            DispatchQueue.main.async { alertVC.show() }
            self.semaphore.wait()
        }
        alertVC.disMissBlock = {
            if self.willShowNextAlertMode { self.showNext() }
        }
        alertQueue.addOperation(operation)
    }
    
    public func showNext()  {
        self.semaphore.signal()
    }
    
}


class RTAlertView: NSObject {
    
    private var alertViewC:UIAlertController!
    fileprivate var disMissBlock:(()->Void)?
    
    fileprivate func alert(title:String,message:String,Alertstyle:UIAlertControllerStyle,actions:[RTAction]) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: Alertstyle)
        for RTAction in actions {
            let action1 = UIAlertAction(title: RTAction.title, style: .default, handler: { (alertAction) in
                RTAction.handle?()
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                    self.disMissBlock?()
                }
            })
            alertVC.addAction(action1)
        }
        alertViewC = alertVC
    }
    fileprivate func show() {
        UIApplication.shared.keyWindow?.rootViewController?.present(alertViewC, animated: true, completion: nil)
    }
}

struct RTAction{
    var handle:(()->Void)?
    var title = ""
    
    init(Title:String,Handle:(()->Void)?) {
        handle = Handle
        title = Title
    }
}
