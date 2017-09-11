//
//  LLTabbarViewController.swift
//  LLProgramFrameworkSwift
//
//  Created by 奥卡姆 on 2017/9/5.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import UIKit

class LLTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()        
        
        guard let jsonPath = Bundle.main.path(forResource: "menu.json", ofType: nil) else {
            return
        }
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {
            return
        }
            
        guard let json = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else {
            return
        }
        
        let anyObject = json as AnyObject
        
        guard let dict = anyObject  as? [String : Any] else {
            return
        }
        
        guard let dictArray = dict["tabbar_items"] as? [[String : Any]] else { return }
        
        for dict in dictArray {
            
            guard let vcName = dict["page"] as? String else {
                continue
            }
            guard let title = dict["title"] as? String else {
                continue
            }
            guard let imageName = dict["normal_icon"] as? String else {
                continue
            }
          addChildVIewController(vcName: vcName, title: title, imageName: imageName)
        }
        
        
    }


    func addChildVIewController(vcName:String,title:String,imageName:String){
                
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"]as! String

        let clsName = namespace + "." + vcName
                
        let cls = NSClassFromString(clsName) as! UIViewController.Type
        
        let vc = cls.init()
        
        vc.title = title
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.yellow], for: UIControlState.normal)
        
        vc.tabBarItem.image = UIImage(named: imageName)
        
        vc.tabBarItem.selectedImage = UIImage(named: "\(imageName)_select")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let navVC = LLNavigationController.init(rootViewController: vc)
        
        addChildViewController(navVC)
        
    }

    

}
