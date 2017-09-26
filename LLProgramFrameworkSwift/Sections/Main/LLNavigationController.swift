//
//  LLNavigationController.swift
//  LLProgramFrameworkSwift
//
//  Created by 奥卡姆 on 2017/9/5.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import UIKit

class LLNavigationController: UINavigationController ,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
                
    }


    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        var title : String?
        
        if childViewControllers.count > 0 {
            title = "返回"
            if childViewControllers.count == 1 {
                title = childViewControllers.first?.title
            }
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(setHighlightedImg:"navigationbar_back_withtext", title: title, target: self, action: #selector(popVC))            
        }
        super.pushViewController(viewController, animated: animated)
    }

    @objc fileprivate func popVC() {
        popViewController(animated:true)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count != 1
    }
    
    

}
