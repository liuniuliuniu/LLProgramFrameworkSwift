//
//  Ext+UIBarButtonItem.swift
//  SwiftPractice
//
//  Created by liushaohua on 15/10/22.
//  Copyright © 2015年 liushaohua. All rights reserved.
//

import UIKit

extension UIBarButtonItem{


    ///UIBarButtonItem
    ///
    /// - parameter setHighlightedImg: 背景图片
    /// - parameter title:             标题
    /// - parameter target:            target
    /// - parameter action:            action 
    ///
    /// - returns: <#return value description#>
    convenience init(setHighlightedImg:String? ,title:String? ,target:Any?,action:Selector) {
        self.init()
        let  button = UIButton(setHighlightImage:setHighlightedImg, title: title, target: target, action: action)
        
        self.customView = button

        
        
    }
    
    
    




}


